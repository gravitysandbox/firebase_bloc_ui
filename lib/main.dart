import 'package:firebase_bloc_ui/src/bloc/counter_bloc.dart';
import 'package:firebase_bloc_ui/src/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        routes: <String, WidgetBuilder> {
          HomeScreen.routeName: (BuildContext context) {
            return const HomeScreen(title: 'Fire-Bloc');
          }
        },
      ),
    );
  }
}
