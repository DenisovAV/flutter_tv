import 'package:flutter/material.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';

class ScaleWidget extends StatelessWidget {
  final Widget child;
  final double ratio;

  const ScaleWidget({
    required this.child,
    required this.ratio,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1 / ratio,
      heightFactor: 1 / ratio,
      child: Transform.scale(
        scale: ratio,
        child: Center(
          child: SizedBox(
            width: kTvSize.width,
            height: kTvSize.height,
            child: child,
          ),
        ),
      ),
    );
  }
}
