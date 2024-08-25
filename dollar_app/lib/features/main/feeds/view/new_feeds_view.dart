import 'dart:io';

import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/main/feeds/providers/post_feeds_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/loading_overlay.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class NewFeedsView extends ConsumerStatefulWidget {
  const NewFeedsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewFeedsViewState();
}

class _NewFeedsViewState extends ConsumerState<NewFeedsView> {
  List<File> attachments = [];
  final _feedController = TextEditingController();
  String? errorMessage;

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

  @override
  void dispose() {
    _feedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: ref.watch(postFeedsProvider).isLoading,
      child: Scaffold(
        appBar: CustomAppBar(
          title: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppPrimaryButton(
                  onPressed: () {
                    ref.read(postFeedsProvider.notifier).postFeeds(
                        content: _feedController.text, attachments: attachments);
                  },
                  putIcon: false,
                  height: 30.h,
                  color: Theme.of(context).colorScheme.primary,
                  width: 100.w,
                  title: "Post"),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            children: [
              Expanded(
                  child: TextFormField(
                    controller: _feedController,
                keyboardType: TextInputType.multiline,
                maxLines: 99999999,
                decoration: InputDecoration.collapsed(
                    hintText: "Whats' popping?",
                    hintStyle: GoogleFonts.redHatDisplay(fontSize: 12.sp)),
                scrollPadding: const EdgeInsets.all(20.0),
                autofocus: true,
              )),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
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
                                icon: const Icon(Icons.close),
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
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickAttachments,
          isExtended: true,
          child: const Icon(Icons.upload),
        ),
      ),
    );
  }
}

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
        return Container();
    }
  }
}

class VideoPreview extends StatefulWidget {
  final File file;

  const VideoPreview({super.key, required this.file});

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
            height: 80,
            width: 80,
            child: VideoPlayer(_controller),
          )
        : Container(
            height: 80,
            width: 80,
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator()),
          );
  }
}
