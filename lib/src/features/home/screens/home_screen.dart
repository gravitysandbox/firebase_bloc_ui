import 'package:firebase_bloc_ui/src/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  final String title;

  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onIncrementHandler() {
    context.read<CounterBloc>().add(CounterEvent.increment);
  }

  void _onDecrementHandler() {
    context.read<CounterBloc>().add(CounterEvent.decrement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocConsumer<CounterBloc, int>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$state',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _onIncrementHandler,
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10.0,
          ),
          FloatingActionButton(
            onPressed: _onDecrementHandler,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
