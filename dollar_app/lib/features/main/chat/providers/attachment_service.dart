import 'dart:io';
import 'package:file_picker/file_picker.dart';

class AttachmentService {
static  Future<File?> pickAttachment() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      return File(result.files.first.path!);
    }
    return null;
  }

static  bool isValidFile(File file) {
    final fileSize = file.lengthSync();
    return fileSize <= 30 * 1024 * 1024; // Max 30MB
  }

 static String? getAttachmentPath(File? file) {
    return file?.path;
  }
}
