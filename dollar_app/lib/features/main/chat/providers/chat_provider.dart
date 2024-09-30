import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dollar_app/services/network/network_repository.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatNotifier extends StateNotifier<AsyncValue<List<dynamic>>> {
  ChatNotifier(this.ref) : super(const AsyncLoading()) {
    connectSocket();
  }
  Ref ref;

  static io.Socket? socket;

  void connectSocket() {
    socket = io.io('https://one0-dollar-backend-service.onrender.com',
        io.OptionBuilder().setTransports(['websocket']).build());

    socket?.onConnect((_) {
      log("Socket connected");
      getMessages();
    });

    // Listen for incoming messages from the server
    socket?.on("message", (data) {
      log("$data");
      _handleIncomingMessage();
    });

    socket?.onDisconnect((_) {
      log("Socket disconnected");
    });
  }

  void sendMessage({
    required String message,
    String? base64Attachment,
    required String userId,
  }) {
    socket?.emit("message", {
      "message": message,
      "attachment": base64Attachment,
      "userId": userId,
    });
  }

  void disconnect() {
    socket?.disconnect();
  }

  Future<void> getMessages() async {
    try {
      state = const AsyncLoading();
      final response =
          await ref.read(networkProvider).getRequest(path: '/chats');
      final List messages = response['data'] ?? [];

      state = AsyncData(messages);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// Handle incoming messages and update the state
  void _handleIncomingMessage() async {
    final response = await ref.read(networkProvider).getRequest(path: '/chats');
    final List messages = response['data'] ?? [];

    state = AsyncData(messages);
  }

  void sendChat({
    required String message,
    required String firstName,
    required String lastName,
    required String senderId,
    required String role,
    required String email,
    String? attachmentPath,
    String? avatar,
    fps.AttachmentType attachmentType = fps.AttachmentType.other,
  }) async {
    // Create a new chat model for the new message

    final chat = {
      "id": "12008500-95ee-498e-951b-c3a96030d764",
      "message": message,
      "attachment": attachmentPath,
      "pin": false,
      "user": {
        "id": "d95cc7db-cef3-4d93-be9b-a621dd783986",
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "avatar": avatar,
        "chatStatus": "inactive",
        "role": role,
        "status": "inactive"
      },
      "createdAt": DateTime.now().toIso8601String()
    };
    log("$chat");

    state = AsyncData([...state.value ?? [], chat]);

    try {
      String? base64Attachment;
      if (attachmentPath != null) {
        final file = File(attachmentPath);
        final bytes = await file.readAsBytes();
        base64Attachment = base64Encode(bytes);
      }

      sendMessage(
        message: message,
        userId: senderId,
        base64Attachment: base64Attachment,
      );

      // Update the message status to delivered
    } catch (e) {
      state = AsyncData([...state.value ?? [], chat]);

      // Optionally, log the error
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final chatProvider =
    StateNotifierProvider<ChatNotifier, AsyncValue<List<dynamic>>>((ref) {
  return ChatNotifier(ref);
});
