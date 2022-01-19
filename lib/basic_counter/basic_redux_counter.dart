import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum CounterAction {
  increment,
  decrement,
}

class CounterState {
  final int count;

  const CounterState(this.count);
}

CounterState counterReducer(CounterState curerntState, dynamic action) {
  if (action == CounterAction.increment) {
    return CounterState(curerntState.count + 1);
  }
  return CounterState(curerntState.count - 1);
}

class MyApp extends StatelessWidget {
  final Store<CounterState> counterStore =
      Store<CounterState>(counterReducer, initialState: CounterState(0));

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: counterStore,
      child: MaterialApp(
        title: 'Material App',
        home: CounterView(),
      ),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Redux Counter'),
      ),
      body: Center(
        child: StoreConnector<CounterState, String>(
          converter: (store) => store.state.count.toString(),
          builder: (context, vm) {
            return Text(vm, style: TextStyle(fontSize: 30));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StoreBuilder<CounterState>(
        builder: (_, store) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                store.dispatch(CounterAction.increment);
              },
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                store.dispatch(CounterAction.decrement);
              },
            ),
          ],
        ),
      ),
    );
  }
}
