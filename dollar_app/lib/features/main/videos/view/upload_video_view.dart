import 'dart:io';

import 'package:dollar_app/features/main/feeds/widgets/file_attachment_widget.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadVideoView extends ConsumerStatefulWidget {
  const UploadVideoView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewFeedsViewState();
}

class _NewFeedsViewState extends ConsumerState<UploadVideoView> {
  List<File> attachments = [];
  final _feedController = TextEditingController();
  String? errorMessage;

  Future<void> _pickAttachments() async {
    try {
      FilePickerResult? result = await fps.FilePickerService.pickAttachments(
          extensions: ['mp4', 'mov']);

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
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Upload Video'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(
          children: [
            TextFormField(
              controller: _feedController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration.collapsed(
                  hintText: "title",
                  hintStyle: GoogleFonts.redHatDisplay(fontSize: 12.sp)),
              scrollPadding: const EdgeInsets.all(20.0),
              autofocus: true,
            ),
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
    );
  }
}
