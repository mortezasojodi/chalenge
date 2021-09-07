import 'dart:async';

import 'package:behtarino/Ui/Login/FirstLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/Theme_bloc.dart';
import 'Common/Variebles/Constants.dart';
import 'Ui/Chat/Chat.dart';
import 'Ui/Home/Home_view.dart';
import 'Ui/Login/Login.dart';
import 'Ui/Splash.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            theme: theme,
            navigatorKey: navigatorKey,
            home: Directionality(
                textDirection: TextDirection.rtl, child: Splash()),
            routes: <String, WidgetBuilder>{
              // '/MainScreen': (BuildContext context) => new MainScreen(),
              '/Home': (BuildContext context) => new Home(),
              '/Login': (BuildContext context) => new Login(),
              '/FirstLogin': (BuildContext context) => new FirstLogin(),
              '/Chat': (BuildContext context) => new Chat(),
            },
          );
        },
      ),
    );
  }
}
