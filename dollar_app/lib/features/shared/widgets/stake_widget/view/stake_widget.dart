import 'package:carousel_slider/carousel_slider.dart';
import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/main/polls/model/polls_video_model.dart';
import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/main/videos/provider/like_delete_video_provider.dart';
import 'package:dollar_app/features/onboarding/provider/indicator_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/app_text_field.dart';
import 'package:dollar_app/features/shared/widgets/stake_widget/helper/stake_helper.dart';
import 'package:dollar_app/features/shared/widgets/stake_widget/widgets/build_position_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StakeWidget extends ConsumerStatefulWidget {
  const StakeWidget({super.key});

  @override
  ConsumerState<StakeWidget> createState() => _StakeWidgetState();
}

class _StakeWidgetState extends ConsumerState<StakeWidget> {
  List<Data> stakes = <Data>[];

  final Map<int, double> _stakeAmounts = {};
  final TextEditingController _stakeAmountController =
      TextEditingController(text: '200');
  bool _isLastItem = false;

  @override
  void dispose() {
    _stakeAmountController.dispose();
    super.dispose();
  }

  void _updateTextFieldValue(int index) {
    _stakeAmountController.text = _stakeAmounts[index]?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(getPollsProvider);
    final stakeHelper = ref.watch(stakeHelperProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                ref.invalidate(inidcatorProvider);
                Navigator.pop(context);
              },
              child: Ink(
                width: 19.w,
                height: 19.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16.r,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Stake',
            style: GoogleFonts.notoSans(
                fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          model.when(
              data: (data) {
                return CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder: (context, index, innerIndex) {
                    final stake = data[index];
                    return Column(
                      children: [
                        Text(
                          "${stake.video!.title} Video",
                          style: GoogleFonts.notoSans(fontSize: 14.sp),
                        ),
                        SizedBox(height: 10.h),
                        FeedsAttachmentWidget(file: stake.video!.videoUrl!),
                        SizedBox(height: 10.h),
                        buildPositionTile(ref, context,
                            videoIndex: index,
                            position: StakePosition.first,
                            title: "FIRST",
                            id: stake.video!.id!),
                        buildPositionTile(ref, context,
                            videoIndex: index,
                            position: StakePosition.second,
                            title: "SECOND",
                            id: stake.video!.id!),
                        buildPositionTile(ref, context,
                            videoIndex: index,
                            position: StakePosition.third,
                            title: "THIRD",
                            id: stake.video!.id!),
                        SizedBox(height: 8.h),
                        const StakeIndicatorWidget(),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    height: 370.h,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      ref.watch(inidcatorProvider.notifier).state = index;
                      _updateTextFieldValue(index);
                      setState(() {
                        _isLastItem = index == 2;
                      });
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text(
                  error.toString(),
                  style: GoogleFonts.lato(),
                );
              },
              loading: () => Container()),
          if (_isLastItem)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),
                const Text(' Stake Amount'),
                AppTextField(
                  controller: _stakeAmountController,
                  readOnly: true,
                  // onchaged: (value) => _updateStakeAmount(index, value!),
                  labelText: '',
                  errorText: '',
                  hintText: '200 naira',
                ),
                SizedBox(height: 8.h),
                const Text('Balance: 2000'),
                SizedBox(height: 8.h),
                AppPrimaryButton(
                  isLoading: ref.watch(likeDeleteVideoProvider).isLoading,
                  onPressed: () {
                    final videosList =
                        stakeHelper.convertSelectedVideosToList();
                    ref
                        .read(likeDeleteVideoProvider.notifier)
                        .stakeVideo(context, amount: 200, videos: videosList);
                  },
                  title: 'Confirm',
                  color: Theme.of(context).colorScheme.primary,
                  putIcon: false,
                  enabled: stakeHelper.selectedVideos.isNotEmpty,
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
          ),
        ],
      ),
    );
  }
}

class StakeIndicatorWidget extends ConsumerStatefulWidget {
  const StakeIndicatorWidget({super.key});

  @override
  ConsumerState<StakeIndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends ConsumerState<StakeIndicatorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(inidcatorProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return Container(
            margin: EdgeInsets.only(right: 7.w),
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0XFFD9D9D9),
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}
