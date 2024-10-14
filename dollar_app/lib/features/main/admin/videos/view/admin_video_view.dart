import 'package:dollar_app/features/main/admin/videos/provider/video_provider.dart';
import 'package:dollar_app/features/main/admin/videos/widgets/delete_video_widget.dart';
import 'package:dollar_app/features/main/admin/videos/widgets/publish_status_widget.dart';
import 'package:dollar_app/features/shared/widgets/app_bottom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/shimmer_widget.dart';
import '../../../feeds/widgets/feeds_attachment_widget.dart';

class AdminVideoView extends ConsumerStatefulWidget {
  const AdminVideoView({
    super.key,
  });

  @override
  ConsumerState<AdminVideoView> createState() => _HomeArtistWidgetState();
}

class _HomeArtistWidgetState extends ConsumerState<AdminVideoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(videoProvider);
    return model.when(
        data: (data) {
          return data.isEmpty
              ? Center(
                  child: Text(
                    "No data to display",
                    style: GoogleFonts.lato(fontSize: 14.sp),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    ref.read(videoProvider.notifier).getVideos();
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: AppTextField(
                            onchaged: (value) {
                              ref
                                  .watch(videoProvider.notifier)
                                  .searchVideos(value!);
                            },
                            suffix: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: '',
                            errorText: '',
                            hintText: 'Search videos'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final video = data[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: video.artist?.avatar != null
                                            ? NetworkImage(video.artist!.avatar!)
                                            : null,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "${video.artist?.firstName} ${video.artist?.lastName}",
                                        style: GoogleFonts.lato(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  if (video.title != null)
                                    Text(
                                      video.title ?? "",
                                      style: GoogleFonts.lato(fontSize: 10.sp),
                                    ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  if (video.videoUrl != null)
                                    FeedsAttachmentWidget(file: video.videoUrl!),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Theme.of(context).primaryColor,
                                        size: 17.r,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        video.likeCount.toString(),
                                        style: GoogleFonts.lato(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.green),
                                        child: Text(
                                          'vote',
                                          style: GoogleFonts.lato(
                                              fontSize: 10.sp, color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        video.voteCount.toString(),
                                        style: GoogleFonts.lato(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      const Spacer(),
                                      getVideoStatus(context,
                                          status: video.status!, id: video.id!),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          AppBottomSheet.showBottomSheet(context,
                                              child:
                                                  DeleteVideoWidget(id: video.id!));
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Theme.of(context).primaryColor,
                                          size: 17.r,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
        error: (e, s) {
          return Text(e.toString());
        },
        loading: () => const ShimmerWidget(
              layoutType: LayoutType.howVideo,
            ));
  }
}

Widget getVideoStatus(context, {required String status, required String id}) {
  if (status == 'published') {
    return AppPrimaryButton(
        onPressed: () {
          AppBottomSheet.showBottomSheet(context,
              child: PublishVideoStatusWidget(status: status, id: id));
        },
        radius: 8,
        putIcon: false,
        enabled: true,
        color: Colors.green,
        width: 100.w,
        height: 20.h,
        title: status);
  }
  return AppPrimaryButton(
      onPressed: () {
        AppBottomSheet.showBottomSheet(context,
            child: PublishVideoStatusWidget(status: status, id: id));
      },
      radius: 8,
      putIcon: false,
      enabled: true,
      color: Colors.amber.shade800,
      width: 100.w,
      height: 20.h,
      title: status);
}
