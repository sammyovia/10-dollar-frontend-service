import 'dart:io';

import 'package:dollar_app/features/main/feeds/widgets/video_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileAttachmentWidget extends StatefulWidget {
  const FileAttachmentWidget({super.key, required this.file});
  final File file;

  @override
  State<FileAttachmentWidget> createState() => _FileAttachmentWidgetState();
}

class _FileAttachmentWidgetState extends State<FileAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    fps.AttachmentType fileType =
        fps.FilePickerService.getFileType(widget.file.path);
    switch (fileType) {
      case fps.AttachmentType.image:
        return Image.file(
          widget.file,
          height: 80.h,
          width: 80.w,
          fit: BoxFit.cover,
        );
      case fps.AttachmentType.video:
        return VideoPreview(file: widget.file);
      case fps.AttachmentType.other:
      case fps.AttachmentType.audio:
        return Container();
    }
  }
}
