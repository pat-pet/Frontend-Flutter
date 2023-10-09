import 'package:flutter/material.dart';
import 'package:frontend_flutter/src/pages/main/chat/chat_detail_page.dart';
import 'package:frontend_flutter/src/view_models/auth_provider.dart';
import 'package:frontend_flutter/src/view_models/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ChatProvider>(context, listen: false).getUserMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                child: const Text(
                  'Recent Chats',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  final message = value.userMessages.entries.toList()[index];
                  return GestureDetector(
                    onTap: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .setUser(message.value.last.receiver!);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              'https://picsum.photos/250?image=9',
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.value.lastOrNull?.receiver
                                          ?.fullName ??
                                      '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(message.value.lastOrNull?.content ?? ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: value.userMessages.length,
                primary: false,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: const Divider(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
