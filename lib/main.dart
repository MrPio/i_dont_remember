import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_dont_remember/firebase_options.dart';
import 'package:i_dont_remember/manager/io_manager.dart';
import 'package:i_dont_remember/view/signin_page.dart';
import 'package:i_dont_remember/view/signup_page.dart';
import 'package:tuple/tuple.dart';

import 'view/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scheda DnD 5e',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, primary: Colors.white),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final Map<String, Tuple2<Offset, Widget>> transitions = {
          '/signup': const Tuple2(Offset(1.0, 0.0), SignUpPage()),
          '/signin': const Tuple2(Offset(-1.0, 0.0), SignInPage()),
        };
        if (transitions.containsKey(settings.name)) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            transitions[settings.name]!.item2,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var tween = Tween(
                  begin: transitions[settings.name]!.item1,
                  end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        }
        return null;
      },
      routes: <String, WidgetBuilder>{
        '/': (context) => const SignInPage(),
      },
    );
  }
}
