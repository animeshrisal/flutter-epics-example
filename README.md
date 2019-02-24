# Flutter Epics Example

A new Flutter project which can work as a boiler plate to use redux and epics. Also contains dev tools that act similar to react native dev tools.

Getting Started docs by https://github.com/AshishBhattarai/

## Getting Started

Copy build.sh to your project and use it to build the project.
Set the `DEV_PACK_DIR` to the dirctory of this package in build.sh

## Example

```dart
main() {
  final appConfig = AppConfig();
  appConfig.title = 'Redux Demo';

  final appStoreConfig = AppStoreConfig<List<CartItem>> (
  	appReducer,			// reducer
  	initialState: List(),
		middleware: myMiddlewareList	// Middleware list
  );

  /* Creates the material app */
  final app = DevToolsApp<List<CartItem>>(
		appStoreConfig,
		appConfig
	);

  app.runDApp(MyHomeWidget()); // MyHome Widget - Stateless/StatefulWidget
}
```
