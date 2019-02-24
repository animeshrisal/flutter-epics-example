library dev_tools_app;

import 'package:flutter/widgets.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epics_example/shake_event.dart';
import 'package:flutter_epics_example/config/build_conf.dart';

/* Wrapper to create material app with dev tools only on debug mode */

/* App Configuration */
class AppConfig {
  String title = 'Default Title';
  ThemeData themeData = ThemeData.dark();
}

/* Application state store config */
class AppStoreConfig<T> {
  Reducer<T> reducer;
  T initialState;
  List<Middleware<T>> middleware;

  AppStoreConfig(this.reducer, {this.initialState, this.middleware = const []});
}

class DevToolsApp<T> {
  Store<T> _store;
  RemoteDevToolsMiddleware _remoteDevTools;

  static final bool isDebug = (BUILD_TYPE == "debug");
  final AppConfig appConfig;

  DevToolsApp(AppStoreConfig<T> appStore, this.appConfig) {
    if (isDebug)
      _debugBuild(appStore);
    else
      _releaseBuid(appStore);
  }

  Store<T> get store => _store;

  // only for debug build
  void connectSocket({String ip = DEBUG_IP}) async {
    _remoteDevTools.socket = SocketClusterWrapper('ws://$ip/socketcluster/');
    try {
      await _remoteDevTools.connect();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void runDApp(Widget homeWidget) {
    runApp(_FlutterReduxApp<T>(this, homeWidget));
  }

  void _debugBuild(AppStoreConfig<T> appStore) {
    // conenct to remote dev tool
    _remoteDevTools = RemoteDevToolsMiddleware('');
    connectSocket();

    List<Middleware<T>> mList = [];
    mList.addAll(appStore.middleware);
    mList.add(_remoteDevTools);

    // create new store
    _store = DevToolsStore<T>(appStore.reducer,
        initialState: appStore.initialState, middleware: mList);
    _remoteDevTools.store = _store;
  }

  void _releaseBuid(AppStoreConfig<T> appStore) {
    _store = Store<T>(appStore.reducer,
        initialState: appStore.initialState, middleware: appStore.middleware);
  }
}

class _FlutterReduxApp<T> extends StatelessWidget {
  final DevToolsApp<T> _devToolsApp;
  final Widget _homeWidget;

  const _FlutterReduxApp(this._devToolsApp, this._homeWidget, {Key key})
      : super(key: key);

  DevToolsApp<T> get devToolsApp => _devToolsApp;
  Widget get homeWidget => _homeWidget;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<T>(
        store: _devToolsApp.store,
        child: MaterialApp(
            theme: _devToolsApp.appConfig.themeData,
            title: _devToolsApp.appConfig.title,
            home: buildHomeWidget()));
  }

  Widget buildHomeWidget() {
    if (DevToolsApp.isDebug) {
      return _HomeWidgetDebug(_devToolsApp, _homeWidget);
    }
    return _HomeWidget(_homeWidget);
  }
}

class _HomeWidgetDebug extends StatefulWidget {
  final DevToolsApp _devToolsApp;
  final Widget _homeWidget;

  const _HomeWidgetDebug(this._devToolsApp, this._homeWidget, {Key key})
      : super(key: key);

  @override
  _HomeWidgetDebugState createState() => _HomeWidgetDebugState();
}

class _HomeWidgetDebugState extends State<_HomeWidgetDebug> {
  final TextEditingController _ipTextController =
      TextEditingController(text: DEBUG_IP);
  ShakeEvent _shakeEvent;
  bool dialogShown = false;

  @override
  void initState() {
    _shakeEvent = ShakeEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (DevToolsApp.isDebug) {
      /* Dialog here */
      _shakeEvent.shakeEventStream.listen((data) async {
        if (!dialogShown) {
          dialogShown = true;
          await _showDialog(context);
          dialogShown = false;
        }
      });
    }
    return widget._homeWidget;
  }

  @override
  void dispose() {
    _shakeEvent.dispose();
    super.dispose();
  }

  Future<String> _showDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 16.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            children: <Widget>[
              TextField(
                controller: _ipTextController,
                decoration: InputDecoration(
                  labelText: 'IP: ',
                  hintText: 'ip:port',
                  border: OutlineInputBorder(),
                ),
              ),
              Center(
                  child: SimpleDialogOption(
                      child: Text('OK'),
                      onPressed: () {
                        widget._devToolsApp
                            .connectSocket(ip: _ipTextController.text);
                        Navigator.of(context).pop();
                      }))
            ],
          );
        });
  }
}

class _HomeWidget extends StatelessWidget {
  final Widget widget;

  _HomeWidget(this.widget, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}
