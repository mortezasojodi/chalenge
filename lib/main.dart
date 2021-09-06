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

/// A [StatelessWidget] which uses:
/// * [bloc](https://pub.dev/packages/bloc)
/// * [flutter_bloc](https://pub.dev/packages/flutter_bloc)
/// to manage the state of a counter.
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

// /// A [StatelessWidget] which demonstrates
// /// how to consume and interact with a [CounterBloc].
// class CounterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Counter')),
//       body: BlocBuilder<CounterBloc, int>(
//         builder: (_, count) {
//           return Center(
//             child: Text('$count', style: Theme.of(context).textTheme.headline1),
//           );
//         },
//       ),
//       floatingActionButton: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: FloatingActionButton(
//               child: const Icon(Icons.add),
//               onPressed: () =>
//                   context.read<CounterBloc>().add(CounterEvent.increment),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: FloatingActionButton(
//               child: const Icon(Icons.remove),
//               onPressed: () =>
//                   context.read<CounterBloc>().add(CounterEvent.decrement),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: FloatingActionButton(
//               child: const Icon(Icons.brightness_6),
//               onPressed: () => context.read<ThemeCubit>().toggleTheme(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: FloatingActionButton(
//               backgroundColor: Colors.red,
//               child: const Icon(Icons.error),
//               onPressed: () =>
//                   context.read<CounterBloc>().add(CounterEvent.error),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// /// {@template counter_bloc}
// /// A simple [Bloc] which manages an `int` as its state.
// /// {@endtemplate}
// class CounterBloc extends Bloc<CounterEvent, int> {
//   /// {@macro counter_bloc}
//   CounterBloc() : super(0);

//   @override
//   Stream<int> mapEventToState(CounterEvent event) async* {
//     switch (event) {
//       case CounterEvent.decrement:
//         yield state - 1;
//         break;
//       case CounterEvent.increment:
//         yield state + 1;
//         break;
//       case CounterEvent.error:
//         addError(Exception('unsupported event'));
//     }
//   }
// }

