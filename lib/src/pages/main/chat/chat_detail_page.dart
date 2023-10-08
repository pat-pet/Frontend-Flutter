import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios_new),
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rehan',
                      style: TextStyle(
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
            itemCount: 12,
            itemBuilder: (context, index) {
              return BubbleSpecialOne(
                text:
                    'Iya kak, kebetulan aku mau keluar kota untuk beberapa saat jadi perlu orang untuk dititipin.',
                isSender: false,
                color: Color(0xFFF0F1F5),
                textStyle: TextStyle(
                  color: Color(0xFF3282B8),
                ),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(14),
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(width: 14),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.send),
                SizedBox(width: 14)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
