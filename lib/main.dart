import 'package:flutter/material.dart';
import './reducers/AppReducer.dart';
import './models/AppState.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:flutter_epics_example/epics/CounterEpic.dart';
import 'package:flutter_epics_example/actions/CounterAction.dart';
import 'package:flutter_epics_example/models/Counter.dart';
import './dev_tools_app.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

void main() async {
  final appConfig = AppConfig();
  appConfig.title = "flutter-epics-example";

  final persistor = Persistor<AppState>(
      storage: FlutterStorage(),
      serializer: JsonSerializer<AppState>(AppState.fromJson));

  final initialState = await persistor.load();

  final appStoreConfig = AppStoreConfig<AppState>(appReducer,
      initialState: initialState ?? AppState.initialState(),
      middleware: [
        EpicMiddleware<AppState>(combineEpics<AppState>([counterEpic])),
        persistor.createMiddleware()
      ]);

  final app = DevToolsApp<AppState>(appStoreConfig, appConfig);

  app.runDApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Five',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Five'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text(
                'You have pushed the button this many times:',
              ),
              new StoreConnector<AppState, _ViewModel>(
                converter: (store) => _ViewModel.create(store),
                builder: (context, _ViewModel viewModel) {
                  return new Text(
                    viewModel.counter.id.toString(),
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: StoreConnector<AppState, _ViewModel>(
          converter: (store) => _ViewModel.create(store),
          builder: (context, _ViewModel viewModel) => FloatingActionButton(
              child: Text("Add"), onPressed: () => viewModel.onIncrement()),
        ));
  }
}

class _ViewModel {
  final Counter counter;
  final Function() onIncrement;
  final Function() onDecrement;

  _ViewModel({this.counter, this.onDecrement, this.onIncrement});

  factory _ViewModel.create(Store<AppState> store) {
    _onIncrement() {
      store.dispatch(IncreaseCounter());
    }

    _onDecrement() {
      store.dispatch(DecreaseCounter());
    }

    return _ViewModel(
        counter: store.state.counterState,
        onDecrement: _onDecrement,
        onIncrement: _onIncrement);
  }
}
