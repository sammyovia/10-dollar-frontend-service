import 'package:dollar_app/features/main/chat/widget/attachment_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SenderMessageWidget extends StatefulWidget {
  final String sender;
  final String? avatar;
  final String? attachmentPath;
  final String message;
  final String time;
  const SenderMessageWidget({
    super.key,
    required this.sender,
    required this.avatar,
    this.attachmentPath,
    required this.message,
    required this.time
  });

  @override
  State<SenderMessageWidget> createState() => _SenderMessageWidgetState();
}

class _SenderMessageWidgetState extends State<SenderMessageWidget> {
  @override
  Widget build(BuildContext context) {
    bool fromNetwork = widget.attachmentPath != null &&
        (widget.attachmentPath!.startsWith('http') ||
            widget.attachmentPath!.startsWith('https'));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            backgroundImage: widget.avatar != null
                ? NetworkImage(widget.avatar!)
                : null,
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sender,
                    style: GoogleFonts.lato(),
                  ),
                  if (widget.attachmentPath != null &&
                      widget.attachmentPath!.isNotEmpty)
                    AttachmentPreviewWidget(
                      attachmentPath: widget.attachmentPath!,
                      onRemove: null,
                      fromNetwork: fromNetwork,
                    ),
                  if (widget.message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.message,
                        style:  GoogleFonts.lato(),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.time, style: GoogleFonts.lato(fontSize: 10.sp),),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
