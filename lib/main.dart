import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/network_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/models/usecase.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/network.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/read_items.dart';
import 'package:firebase_bloc_ui/src/features/home/screens/disabled_network_screen.dart';
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
  locator<NetworkImpl>().listenNetworkChanges();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ArrayBloc _arrayBloc;
  late NetworkBloc _networkBloc;

  @override
  void initState() {
    super.initState();
    _arrayBloc = locator<ArrayBloc>();
    _networkBloc = locator<NetworkBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _arrayBloc,
        ),
        BlocProvider.value(
          value: _networkBloc,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<NetworkBloc, bool>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, isConnectToNetwork) {
            return isConnectToNetwork
                ? const HomeScreen(title: 'Fire-Bloc')
                : const DisabledNetworkScreen(title: 'Fire-Bloc');
          },
        ),
      ),
    );
  }
}
