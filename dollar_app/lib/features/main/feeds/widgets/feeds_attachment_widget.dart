import 'package:dollar_app/features/main/feeds/widgets/feeds_video_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedsAttachmentWidget extends StatefulWidget {
  const FeedsAttachmentWidget(
      {super.key, required this.file, this.height, this.width});
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
        return GestureDetector(
          onTap: ()=> _showFullImageView(context),
          child: Image.network(
            widget.file,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
          ),
        );

      case fps.AttachmentType.video:
        return FeedsVideoPreview(file: widget.file);
      case fps.AttachmentType.other:
      case fps.AttachmentType.audio:
        return Container();
    }
  }

  void _showFullImageView(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          child: Center(
            child: Image.network(
              widget.file,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
