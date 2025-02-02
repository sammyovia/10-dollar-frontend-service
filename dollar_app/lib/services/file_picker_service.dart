import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class FilePickerService {
  static const int maxFileSize = 30 * 1024 * 1024; // 30MB in bytes

  // Method to pick files (supports custom extensions including images, videos, and audio)
  static Future<FilePickerResult?> pickAttachments(
      {List<String>? extensions}) async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions ??
          ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov', 'mp3', 'wav', 'aac'],
      allowMultiple: false,
    );
  }

  // Method to get valid files (checks if they are images, videos, or audio and below the max size)
  static List<File> getValidFiles(FilePickerResult result) {
    List<File> validFiles = [];
    for (var file in result.files) {
      if (file.path != null) {
        File fileObj = File(file.path!);
        String extension = file.extension?.toLowerCase() ?? '';
        if (['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov', 'mp3', 'wav', 'aac']
                .contains(extension) &&
            fileObj.lengthSync() <= maxFileSize) {
          validFiles.add(fileObj);
        }
      }
    }
    return validFiles;
  }

  // Method to determine the type of attachment (image, video, or audio)
  static AttachmentType getFileType(String filePath) {
    String extension = path.extension(filePath).toLowerCase();
    if (['.jpg', '.jpeg', '.png', '.gif'].contains(extension)) {
      return AttachmentType.image;
    } else if (['.mp4', '.mov', '.avi'].contains(extension)) {
      return AttachmentType.video;
    } else if (['.mp3', '.wav', '.aac'].contains(extension)) {
      return AttachmentType.audio;
    } else {
      return AttachmentType.other;
    }
  }

  // Method to get a reason why a file is too large
  static String getFileSizeReason(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMB = sizeInBytes / (1024 * 1024);
    return "File size (${sizeInMB.toStringAsFixed(2)} MB) exceeds the 30 MB limit.";
  }
}

enum AttachmentType { image, video, audio, other }
