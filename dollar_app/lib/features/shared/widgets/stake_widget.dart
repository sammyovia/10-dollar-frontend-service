import 'package:carousel_slider/carousel_slider.dart';
import 'package:dollar_app/features/main/feeds/widgets/feeds_attachment_widget.dart';
import 'package:dollar_app/features/main/polls/model/polls_video_model.dart';
import 'package:dollar_app/features/main/polls/provider/get_polls_provider.dart';
import 'package:dollar_app/features/onboarding/provider/indicator_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_bottom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/app_text_field.dart';
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
  final Map<int, StakePosition?> _selectedPositions = {};
  final Map<StakePosition, int?> _globalSelectedPositions = {};
  final Map<int, double> _stakeAmounts = {};
  final TextEditingController _stakeAmountController =
      TextEditingController(text: '200');
  bool _isLastItem = false;

  @override
  void dispose() {
    _stakeAmountController.dispose();
    super.dispose();
  }

  void _handlePositionSelection(int videoIndex, StakePosition position) {
    setState(() {
      if (_selectedPositions[videoIndex] == position) {
        // Deselect if already selected
        _selectedPositions.remove(videoIndex);
        _globalSelectedPositions.remove(position);
      } else {
        // Deselect previous position for this video if any
        if (_selectedPositions.containsKey(videoIndex)) {
          _globalSelectedPositions.remove(_selectedPositions[videoIndex]);
        }

        // Select new position
        _selectedPositions[videoIndex] = position;
        _globalSelectedPositions[position] = videoIndex;
      }
    });
  }

  bool _isPositionGloballySelected(StakePosition position) {
    return _globalSelectedPositions.containsKey(position);
  }


  void _updateTextFieldValue(int index) {
    _stakeAmountController.text = _stakeAmounts[index]?.toString() ?? '';
  }



  void _onConfirm(context) {
    Navigator.pop(context);
    AppBottomSheet.showBottomSheet(
        isDismissible: false,
        context,
        child: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 40.r,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text('Stake Successful',
                    style: GoogleFonts.lato(fontSize: 32.sp)),
                SizedBox(
                  height: 20.h,
                ),
                AppPrimaryButton(
                  putIcon: false,
                  enabled: true,
                  color: Theme.of(context).colorScheme.primary,
                  title: "Back To Home",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(getPollsProvider);
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
                  itemCount: data.length,
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
                        _buildPositionTile(
                            index, StakePosition.first, "First Place"),
                        _buildPositionTile(
                            index, StakePosition.second, "Second Place"),
                        _buildPositionTile(
                            index, StakePosition.third, "Third Place"),
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
                        _isLastItem = index == data.length - 1;
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
                  onPressed: () {
                    _onConfirm(context);
                  },
                  title: 'Confirm',
                  color: Theme.of(context).colorScheme.primary,
                  putIcon: false,
                  enabled: true,
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

  Widget _buildPositionTile(
      int videoIndex, StakePosition position, String title) {
    bool isSelected = _selectedPositions[videoIndex] == position;
    bool isDisabled = _isPositionGloballySelected(position) && !isSelected;
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () => _handlePositionSelection(videoIndex, position),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: isSelected ? Colors.grey : null,
        minVerticalPadding: 8.h,
        minTileHeight: 8.h,
        title: Text(title),
        trailing: CustomRadioButton(
          activeColor:
              isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
        enabled: !isDisabled,
      ),
    );
  }
}

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({super.key, this.activeColor});
  final Color? activeColor;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 13.w,
          height: 13.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.activeColor,
          ),
        ),
      ),
    );
  }
}

enum StakePosition { first, second, third }

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
