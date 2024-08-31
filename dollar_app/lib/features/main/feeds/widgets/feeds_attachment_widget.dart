import 'package:dollar_app/features/main/feeds/widgets/feeds_video_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedsAttachmentWidget extends StatefulWidget {
  const FeedsAttachmentWidget({super.key, required this.file, this.height,
  this.width});
  final String file;
  final double? height;
  final double? width;

  @override
  State<FeedsAttachmentWidget> createState() => _FileAttachmentWidgetState();
}

class _FileAttachmentWidgetState extends State<FeedsAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    fps.AttachmentType fileType =
        fps.FilePickerService.getFileType(widget.file);
    switch (fileType) {
      case fps.AttachmentType.image:
        return Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300,
            image: DecorationImage(
                image: NetworkImage(widget.file), fit: BoxFit.cover),
          ),
        );

      case fps.AttachmentType.video:
        return FeedsVideoPreview(file: widget.file);
      case fps.AttachmentType.other:
        return Container();
    }
  }
}
