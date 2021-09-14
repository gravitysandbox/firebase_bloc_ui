import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/read_items.dart';
import 'package:firebase_bloc_ui/src/features/home/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  Firebase.initializeApp().then((_) {
    locator<ReadItems>().call(NoParams());
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ArrayBloc _arrayBloc;

  @override
  void initState() {
    super.initState();
    _arrayBloc = locator<ArrayBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _arrayBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        routes: <String, WidgetBuilder>{
          HomeScreen.routeName: (BuildContext context) {
            return const HomeScreen(title: 'Fire-Bloc');
          }
        },
      ),
    );
  }
}
