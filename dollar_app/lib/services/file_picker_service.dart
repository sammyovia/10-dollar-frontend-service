import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class FilePickerService {
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB in bytes

  static Future<FilePickerResult?> pickAttachments(
      {List<String>? extensions}) async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions:
          extensions ?? ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov'],
      allowMultiple: false,
    );
  }

  static List<File> getValidFiles(FilePickerResult result) {
    List<File> validFiles = [];
    for (var file in result.files) {
      if (file.path != null) {
        File fileObj = File(file.path!);
        String extension = file.extension?.toLowerCase() ?? '';
        if (['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov'].contains(extension) &&
            fileObj.lengthSync() <= maxFileSize) {
          validFiles.add(fileObj);
        }
      }
    }
    return validFiles;
  }

  static AttachmentType getFileType(String filePath) {
    String extension = path.extension(filePath).toLowerCase();
    if (['.jpg', '.jpeg', '.png', '.gif'].contains(extension)) {
      return AttachmentType.image;
    } else if (['.mp4', '.mov', '.avi'].contains(extension)) {
      return AttachmentType.video;
    } else {
      return AttachmentType.other;
    }
  }

  static String getFileSizeReason(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMB = sizeInBytes / (1024 * 1024);
    return "File size (${sizeInMB.toStringAsFixed(2)} MB) exceeds the 5 MB limit.";
  }
}

enum AttachmentType { image, video, other }
