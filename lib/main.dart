import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/movies_bloc.dart';
import 'package:flutter_tv/framework/remote_controller.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/focus/scale_widget.dart';
import 'package:flutter_tv/ui/HomePage.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (MyPlatform.isTVOS) {
    RemoteController().init();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const screen = HomePage();
    print(MyPlatform.isAndroidTV);
    print(kTvSize.width);
    print(width);
    print(pixelRatio);
    return MaterialApp(
      home: BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
          child: isScaled
              ? ScaleWidget(
                  child: screen,
                )
              : screen),
    );
  }
}
