import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dollar_app/services/file_picker_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class AttachmentPreviewWidget extends StatefulWidget {
  final String attachmentPath;
  final VoidCallback? onRemove;
  final bool fromNetwork;

  const AttachmentPreviewWidget({
    super.key,
    required this.attachmentPath,
    this.onRemove,
    this.fromNetwork = false,
  });

  @override
  State createState() => _AttachmentPreviewWidgetState();
}

class _AttachmentPreviewWidgetState extends State<AttachmentPreviewWidget> {
  VideoPlayerController? _videoController;
  AttachmentType _attachmentType = AttachmentType.other;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _attachmentType = FilePickerService.getFileType(widget.attachmentPath);
    _initializeMediaController();
  }

  void _initializeMediaController() {
    switch (_attachmentType) {
      case AttachmentType.video:
        _videoController =
            VideoPlayerController.file(File(widget.attachmentPath))
              ..initialize().then((_) {
                setState(() {});
              });
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _playPauseMedia() {
    setState(() {
      if (_attachmentType == AttachmentType.video) {
        if (_videoController!.value.isPlaying) {
          _videoController!.pause();
        } else {
          _videoController!.play();
        }
        _isPlaying = _videoController!.value.isPlaying;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 150.h,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRect(
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildAttachmentPreview(widget.fromNetwork),
                if (widget.onRemove != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: widget.onRemove,
                    ),
                  ),
                if (_attachmentType == AttachmentType.video ||
                    _attachmentType == AttachmentType.audio)
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: _playPauseMedia,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentPreview(bool fromNetWork) {
    if (_attachmentType == AttachmentType.image) {
      if (fromNetWork) {
        // Image from the network
        return Image.network(
          width: double.infinity,
          widget.attachmentPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text('Image failed to load'));
          },
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        );
      } else {
        // Image from the file system
        final file = File(widget.attachmentPath);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Failed to load image'));
            },
          );
        } else {
          return const Center(child: Text('File not found'));
        }
      }
    } else if (_attachmentType == AttachmentType.video) {
      return _videoController!.value.isInitialized
          ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController!.value.size.width,
                height: _videoController!.value.size.height,
                child: VideoPlayer(_videoController!),
              ),
            )
          : const Center(child: CircularProgressIndicator());
    } else if (_attachmentType == AttachmentType.audio) {
      return const Center(
        child: Icon(Icons.audio_file, size: 50, color: Colors.blue),
      );
    } else {
      return const Center(child: Text('Unsupported file type'));
    }
  }
}
