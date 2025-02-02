import 'package:dollar_app/features/main/chat/model/send_chat_model.dart';
import 'package:dollar_app/features/main/chat/widget/attachment_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiverMessageWidget extends StatelessWidget {
  final SendChatModel chat;
  final VoidCallback onRetry;

  const ReceiverMessageWidget({
    super.key,
    required this.chat,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250.w),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (chat.attachmentType != fps.AttachmentType.other)
                  AttachmentPreviewWidget(
                    attachmentPath: chat.attachmentPath!,
                    onRemove: null,
                    fromNetwork: true,
                  ),
                if (chat.message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      chat.message,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                // const SizedBox(height: 4),
                // _buildStatusIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
