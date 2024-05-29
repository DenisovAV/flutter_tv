import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/gemini_bloc.dart';
import 'package:flutter_tv/ui/widgets/ai_chat/chat_message.dart';

class GeminiMessageOverlay extends StatefulWidget {
  const GeminiMessageOverlay({
    required this.token,
    super.key,
  });

  final String? token;

  @override
  GeminiMessageOverlayState createState() => GeminiMessageOverlayState();
}

class GeminiMessageOverlayState extends State<GeminiMessageOverlay> {
  var _message = '';
  var _done = false;

  @override
  void didUpdateWidget(GeminiMessageOverlay oldWidget) {
    if (widget.token != null) {
      _message = '$_message${widget.token}';
    } else {
      _done = true;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChatMessageWidget(message: _message),
        if (_done)
          ElevatedButton(
            onPressed: () => context.read<GeminiBloc>().add(GeminiRefreshEvent()),
            child: Text('Done'),
          ),
      ],
      reverse: true,
    );
  }
}
