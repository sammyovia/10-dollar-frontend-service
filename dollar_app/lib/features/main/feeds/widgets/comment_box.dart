import 'dart:io';

import 'package:dollar_app/features/main/feeds/providers/comment_provider.dart';
import 'package:dollar_app/features/main/feeds/providers/get_comments_provider.dart';
import 'package:dollar_app/features/main/feeds/widgets/file_attachment_widget.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:dollar_app/services/date_manipulation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;

class CommentBox extends ConsumerStatefulWidget {
  const CommentBox(
      {super.key, required this.postId, this.showBottomSheet = true});
  final String postId;
  final bool showBottomSheet;

  @override
  ConsumerState<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends ConsumerState<CommentBox> {
  List<File> attachments = [];
  final _commentController = TextEditingController();
  String? errorMessage;
  bool isPosting = false;

  Future<void> _pickAttachments() async {
    try {
      FilePickerResult? result = await fps.FilePickerService.pickAttachments();

      if (result != null) {
        List<File> validFiles = fps.FilePickerService.getValidFiles(result);
        List<File> invalidFiles = result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!))
            .where((file) => !validFiles.contains(file))
            .toList();

        if (validFiles.isNotEmpty) {
          setState(() {
            attachments.addAll(validFiles);
            errorMessage = null;
          });
        }

        if (invalidFiles.isNotEmpty) {
          invalidFiles.map((file) {
            if (file.lengthSync() > fps.FilePickerService.maxFileSize) {
              errorMessage = fps.FilePickerService.getFileSizeReason(file);
              setState(() {});
            }
          }).toList();
        }

        if (validFiles.isEmpty && invalidFiles.isEmpty) {
          setState(() {
            errorMessage = "No files were selected.";
          });
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred while picking files: $e";
      });
    }
  }

  void postComment() {
    if (_commentController.text.isNotEmpty) {
      ref.read(postCommentProvider.notifier).postComments(context,
          content: _commentController.text,
          attachments: attachments,
          postId: widget.postId);

      _commentController.clear();

      _focus.unfocus();
    }
  }

  final FocusNode _focus = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getCommentProvider.notifier).getComments(widget.postId);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(getCommentProvider);
    // Calculate the height of the screen minus the app bar height and some additional padding
    final double screenHeight = MediaQuery.of(context).size.height;
    const double appBarHeight = kToolbarHeight; // Default app bar height
    final double bottomSheetHeight = screenHeight -
        appBarHeight -
        50.h; // Subtracting additional space for padding

    return SizedBox(
      height: bottomSheetHeight,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            // Scrollable comments area
            if (widget.showBottomSheet)
              Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Comments",
                    style: GoogleFonts.notoSans(fontSize: 16.sp),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                ],
              ),

            Expanded(
              child: comments.when(
                  data: (data) {
                    return data.isEmpty
                        ? const Center(
                            child: Text('No comments to display'),
                          )
                        : ListView.builder(
                            physics: widget.showBottomSheet
                                ? null
                                : const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final comment = data[index];
                              return CommentItem(
                                sender:
                                    "${comment.user.firstName}  ${comment.user.lastName}",
                                comment: comment.content,
                                image: comment.user.avatar,
                                contentImage: comment.attachment,
                                date: comment.createdAt,
                              );
                            });
                  },
                  error: (e, s) {
                    return Text(e.toString());
                  },
                  loading: () => const ShimmerWidget(
                        layoutType: LayoutType.howVideo,
                      )),
            ),
            // const Spacer(),
            // Input area
            if (widget.showBottomSheet)
              Container(
                padding: const EdgeInsets.all(8.0),
                height: _focus.hasFocus ? 100 : 50.h,
                child: TextFormField(
                  controller: _commentController,
                  focusNode: _focus,
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        size: 17.r,
                      ),
                      onPressed: _pickAttachments,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 17.r,
                      ),
                      onPressed: postComment,
                    ),
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
                    hintText: 'your comment...',
                  ),
                ),
              ),
            SizedBox(
                height: 2.0
                    .h), // Add some spacing between the TextField and the icons
            if (attachments.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: attachments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          FileAttachmentWidget(file: attachments[index]),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  attachments.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            if (ref.watch(postCommentProvider).isLoading) const Text('posting'),


            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final String sender;
  final String comment;
  final String? image;
  final String? contentImage;
  final String date;

  const CommentItem(
      {super.key,
      required this.sender,
      required this.comment,
      required this.image,
      required this.contentImage,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: image != null ? NetworkImage(image!) : null,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sender,
                      style: GoogleFonts.lato(),
                    ),
                    if (contentImage != null)
                      Image.network(
                        contentImage!,
                        width: double.infinity,
                       
                      ),
                    if (comment.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          comment,
                          style: GoogleFonts.lato(),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DataManipulation.timeAgo(date),
                          style: GoogleFonts.lato(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )

       
        );
  }
}
