import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFF757575),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: message.isNotEmpty
                ? MarkdownBody(
                    data: message,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundImage: AssetImage('assets/gemini.png'),
          ),
        ],
      ),
    );
  }
}
