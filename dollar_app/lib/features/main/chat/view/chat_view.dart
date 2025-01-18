import 'dart:developer';
import 'dart:io';
import 'package:dollar_app/features/main/chat/providers/attachment_service.dart';
import 'package:dollar_app/features/main/chat/providers/chat_provider.dart';
import 'package:dollar_app/features/main/chat/widget/sender_message_widget.dart';
import 'package:dollar_app/features/main/profile/model/profile_model.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:dollar_app/features/main/chat/widget/attachment_preview_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../profile/providers/get_profile_provider.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  late TextEditingController _chatController;
  File? _selectedAttachment;
  String? userId;
  final scrollController = ScrollController();
  ProfileData? profile;

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();

    getUserId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserProfile();
    });
  }

  void getUserProfile() async {
    profile = await ref.read(getProfileProvider.notifier).getProfile();
    setState(() {});
  }

  void getUserId() async {
    final token = TokenStorage();
    userId = await token.getUserId();
    log(userId.toString());
  }

  @override
  void dispose() {
    _chatController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _removeAttachment() {
    setState(() {
      _selectedAttachment = null;
    });
  }

  void _sendMessage() async {
    final message = _chatController.text.trim();
    final attachmentPath = _selectedAttachment?.path;

    if (message.isNotEmpty || attachmentPath != null) {
      ref.read(chatProvider.notifier).sendChat(
            message: message,
            senderId: userId!,
            firstName: profile?.firstName ?? "John",
            lastName: profile?.lastName ?? "Doe",
            avatar: profile?.avatar,
            attachmentPath: attachmentPath,
            attachmentType: attachmentPath != null
                ? fps.FilePickerService.getFileType(attachmentPath)
                : fps.AttachmentType.other,
            role: profile?.role ?? '',
            email: profile?.email ?? '',
          );

      _chatController.clear();
      setState(() {
        _selectedAttachment = null;
      });
    }
  }

  Map<String, List<dynamic>> _groupChatsByDate(List<dynamic> chats) {
    final groupedChats = <String, List<dynamic>>{};
    for (final chat in chats) {
      final date = DateTime.parse(chat['createdAt']);
      final formattedDate = _formatDate(date);
      if (!groupedChats.containsKey(formattedDate)) {
        groupedChats[formattedDate] = [];
      }
      groupedChats[formattedDate]!.add(chat);
    }
    return groupedChats;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  String _formatTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(chatProvider);
    log(userId.toString());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        showLeading: true,
        showProfile: true,
        showSearch: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(chatProvider.notifier).getMessages();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                "Chat",
                style: GoogleFonts.lato(fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              //thickness: 2,
            ),
            Expanded(
                child: chats.when(
                    data: (data) {
                      final groupedChats = _groupChatsByDate(data);
                      final sortedDates = groupedChats.keys.toList()
                        ..sort((a, b) {
                          if (a == 'Today') return 1;
                          if (b == 'Today') return -1;
                          if (a == 'Yesterday') return 1;
                          if (b == 'Yesterday') return -1;
                          return DateTime.parse(b).compareTo(DateTime.parse(a));
                        });
                      return data.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "No chats to display",
                                    style: GoogleFonts.lato(),
                                  ),
                                ),
                                AppPrimaryButton(
                                  enabled: true,
                                  putIcon: false,
                                  width: 100.w,
                                  height: 30.h,
                                  title: "Retry",
                                  onPressed: () {
                                    ref
                                        .read(chatProvider.notifier)
                                        .getMessages();
                                  },
                                )
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                controller: scrollController,
                                itemCount: sortedDates.length,
                                itemBuilder: (context, index) {
                                  final date = sortedDates[
                                      sortedDates.length - 1 - index];
                                  final messagesForDate =
                                      groupedChats[date] ?? [];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 8.h),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Theme.of(context)
                                                  .dividerColor,
                                            )),
                                            Text(
                                              date,
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                                child: Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Theme.of(context)
                                                  .dividerColor,
                                            )),
                                          ],
                                        ),
                                      ),
                                      ...messagesForDate.map((message) {
                                        return SenderMessageWidget(
                                          onDelete: () async {
                                            try {
                                              await ref
                                                  .read(chatProvider.notifier)
                                                  .deleteMessage(
                                                      messageId: message['id'],
                                                      senderId: message['user']
                                                          ['id']);
                                              // Show success toast if needed
                                            } catch (e) {
                                              // Show error toast if needed
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Failed to delete message: ${e.toString()}')),
                                                );
                                              }
                                            }
                                          },
                                          currentUserRole: profile?.role ?? "",
                                          senderRole: message['user']['role'],
                                          senderId: message['user']['id'],
                                          userId: profile!.id!,
                                          sender:
                                              "${message['user']['firstName'] ?? "John"} ${message['user']['lastName'] ?? "Doe"}",
                                          message: message['message'],
                                          attachmentPath: message['attachment'],
                                          avatar: message['user']['avatar'],
                                          time: _formatTime(
                                              message['createdAt'] ??
                                                  DateTime.now()
                                                      .toIso8601String()),
                                        );
                                      })
                                    ],
                                  );
                                },
                              ),
                            );
                    },
                    error: (e, s) {
                      return Center(
                        child: Text(
                          e.toString(),
                        ),
                      );
                    },
                    loading: () => const ShimmerWidget(
                          layoutType: LayoutType.howVideo,
                        ))),
            if (_selectedAttachment != null)
              AttachmentPreviewWidget(
                attachmentPath: _selectedAttachment!.path,
                onRemove: _removeAttachment,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _chatController,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () async {
                      final attachments =
                          await AttachmentService.pickAttachment();
                      if (attachments != null &&
                          AttachmentService.isValidFile(attachments)) {
                        setState(() {
                          _selectedAttachment = attachments;
                        });
                      }
                    },
                    icon: const Icon(Icons.attach_file),
                    iconSize: 17.r,
                  ),
                  suffixIcon: profile?.chatStatus == "active"
                      ? IconButton(
                          onPressed: _sendMessage,
                          icon: const Icon(Icons.send_sharp),
                          iconSize: 17.r,
                        )
                      : null,
                  hintText: 'Type a message...',
                  hintStyle: GoogleFonts.lato(fontSize: 12.sp),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
