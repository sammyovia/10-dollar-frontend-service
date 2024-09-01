import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final List<ChatItem> _chats = [
    ChatItem(
        name: "John Doe", lastMessage: "Hello!", unreadCount: 2, isRead: false),
    ChatItem(
        name: "Jane Smith",
        lastMessage: "See you later",
        unreadCount: 0,
        isRead: true),
    // Add more chat items as needed
  ];

  List<ChatItem> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _filteredChats = _chats;
  }

  void _filterChats(String query) {
    setState(() {
      _filteredChats = _chats
          .where(
              (chat) => chat.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.search,
              color: Colors.black,
              size: 20.r,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyBold.notification,
              color: Colors.black,
              size: 20.r,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.grey.shade300,
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Text(
              "Chats",
              style: GoogleFonts.lato(fontSize: 16.sp),
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                hintText: 'Search...',
                prefixIcon: Icon(
                  IconlyBroken.search,
                  size: 20.r,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: _filterChats,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredChats.length,
              itemBuilder: (context, index) {
                final chat = _filteredChats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    //child: Text(chat.name[0]),
                  ),
                  title: Text(chat.name),
                  subtitle: Text(chat.lastMessage),
                  trailing: chat.unreadCount > 0
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : null,
                  onTap: () {
                    // Navigate to chat page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(chatItem: chat),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String lastMessage;
  final int unreadCount;
  final bool isRead;

  ChatItem({
    required this.name,
    required this.lastMessage,
    required this.unreadCount,
    required this.isRead,
  });
}

class ChatPage extends StatelessWidget {
  final ChatItem chatItem;

  const ChatPage({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatItem.name),
      ),
      body: Center(
        child: Text('Chat with ${chatItem.name}'),
      ),
    );
  }
}
