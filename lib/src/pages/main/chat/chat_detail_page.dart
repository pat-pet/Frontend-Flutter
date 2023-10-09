import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/src/view_models/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final Socket _socket = io(
    'http://192.168.100.19:3000',
    OptionBuilder().setTransports(['websocket']).build(),
  );
  TextEditingController _messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _socket.onConnect((data) {
      debugPrint('Connected');
    });
    _socket.onDisconnect((data) {
      debugPrint('onDisconnect: $data');
    });
    _socket.onConnectError((data) {
      debugPrint('onConnectError: $data');
    });
    _socket.on('receive_message', (data) {
      print('Received Message $data');
      Future.microtask(() {
        Provider.of<ChatProvider>(context, listen: false).addMessage(
          data['senderId'],
          data['senderName'],
          data['content'],
        );
      });
    });
    _socket.connect();
    Future.microtask(
      () => {
        Provider.of<ChatProvider>(context, listen: false).getMessages(
          Provider.of<ChatProvider>(context, listen: false)
                  .user
                  ?.id
                  .toString() ??
              "",
        )
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 24,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 24),
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
                              value.user?.fullName ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    itemCount: value.messages.length,
                    itemBuilder: (context, index) {
                      final message = value.messages[index];
                      return BubbleSpecialOne(
                        text: message.content ?? "",
                        isSender:
                            value.senderId == message.sender?.id.toString(),
                        color: const Color(0xFFF0F1F5),
                        textStyle: const TextStyle(
                          color: Color(0xFF3282B8),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        Expanded(
                          child: TextField(
                            controller: _messageTextController,
                            decoration: const InputDecoration(
                              hintText: "Type something...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            value.sendMessage(_messageTextController.text);
                            _socket.emit('send_message', {
                              'content': _messageTextController.text,
                              'senderId': int.parse(value.senderId),
                              'senderName': value.senderName,
                            });
                            _messageTextController.clear();
                          },
                          icon: const Icon(Icons.send),
                        ),
                        const SizedBox(width: 14)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
