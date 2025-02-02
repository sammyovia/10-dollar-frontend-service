import 'package:dollar_app/features/main/chat/enum/message_status.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;

class SendChatModel {
  final String sender;
  final String message;
  final String? attachmentPath;
  final String senderId;
  final String? avatar;
  final MessageStatus status; // Add status field
  final fps.AttachmentType attachmentType;
  final String? createdAt;

  SendChatModel({
    required this.sender,
    required this.message,
    this.attachmentPath,
    required this.senderId,
    this.avatar,
    this.status = MessageStatus.sending, // Default to sending
    this.attachmentType = fps.AttachmentType.other,
    this.createdAt
  });

  SendChatModel copyWith({
    String? sender,
    String? message,
    String? attachmentPath,
    String? senderId,
    String? avatar,
    MessageStatus? status,
    fps.AttachmentType? attachmentType,
    String? createdAt,
  }) {
    return SendChatModel(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      attachmentPath: attachmentPath ?? this.attachmentPath,
      senderId: senderId ?? this.senderId,
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
      attachmentType: attachmentType ?? this.attachmentType,
      createdAt:  createdAt ?? this.createdAt
    );
  }

  @override
  String toString() {
    return "sender: $sender, message: $message, attachmemt: $attachmentPath, senderId: $senderId";
  }
}
