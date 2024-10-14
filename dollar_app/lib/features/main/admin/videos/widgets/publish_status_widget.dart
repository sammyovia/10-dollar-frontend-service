import 'package:dollar_app/features/main/admin/videos/provider/publish_video_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/app_primary_button.dart';

class PublishVideoStatusWidget extends ConsumerStatefulWidget {
  const PublishVideoStatusWidget(
      {super.key, required this.status, required this.id});

  final String status;
  final String id;

  @override
  ConsumerState<PublishVideoStatusWidget> createState() =>
      _DeleteUserWidgetState();
}

class _DeleteUserWidgetState extends ConsumerState<PublishVideoStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            widget.status == 'published' ? 'UnPublish Video' : 'Publish Video',
            style: GoogleFonts.aBeeZee(fontSize: 18.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppPrimaryButton(
                isLoading: ref.watch(publishVideoProvider).isLoading,
                onPressed: () {
                  if (widget.status == 'published') {
                    ref
                        .read(publishVideoProvider.notifier)
                        .unPublishVideo(context, id: widget.id);
                  } else {
                    ref
                        .read(publishVideoProvider.notifier)
                        .publishVideo(context, id: widget.id);
                  }
                },
                color: widget.status == 'published' ? Colors.amber.shade700 : Colors.green,
                enabled: true,
                putIcon: false,
                height: 35.h,
                width: 100.w,
                title: widget.status == 'published'
                    ? 'UnPublish'
                    : 'Publish Video',
              ),
              SizedBox(
                width: 30.w,
              ),
              AppPrimaryButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  color: Colors.grey,
                  enabled: true,
                  putIcon: false,
                  height: 35.h,
                  width: 100.w,
                  title: "Back")
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
