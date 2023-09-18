import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/auth_bloc.dart';
import 'package:flutter_tv/framework/remote_controller.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/focus/scale_widget.dart';
import 'package:flutter_tv/ui/main_screen.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (MyPlatform.isTVOS) {
    RemoteController().init();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders(
    [
      GoogleProvider(clientId: DefaultFirebaseOptions.webClientId),
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const screen = MainScreen();
    return MaterialApp(
      home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc()..add(AuthInitializeEvent()),
            ),
          ],
          child: isScaled
              ? ScaleWidget(
                  child: screen,
                )
              : screen),
    );
  }
}
