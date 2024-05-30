import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
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
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: message.isNotEmpty
                  ? MarkdownBody(
                      styleSheet: MarkdownStyleSheet(
                        h1: TextStyle(color: Colors.white),
                        h2: TextStyle(color: Colors.white),
                        h3: TextStyle(color: Colors.white),
                        p: TextStyle(color: Colors.white),
                        strong: TextStyle(color: Colors.white),
                        em: TextStyle(color: Colors.white),
                        listBullet: TextStyle(color: Colors.white),
                        blockquote: TextStyle(color: Colors.white),
                        code: TextStyle(color: Colors.white),
                      ),
                      data: message,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor: Colors.black,
              foregroundImage: AssetImage('assets/gemini.png'),
            ),
          ],
        ),
    );
  }
}
