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
    if (widget.token != null && widget.token!.isNotEmpty) {
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
        if (_done)
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black.withOpacity(0.8);
                  }
                  return Colors.black;
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Colors.white;
                },
              ),
            ),
            onPressed: () => context.read<GeminiBloc>().add(GeminiRefreshEvent()),
            child: Text('Done'),
          ),
        ChatMessageWidget(message: _message),

      ],
      reverse: true,
    );
  }
}
