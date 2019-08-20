import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_tinder_template/actions/actions.dart';
import 'package:flutter_tinder_template/containers/main_page.dart';
import 'package:flutter_tinder_template/containers/profile_details_page.dart';
import 'package:flutter_tinder_template/middleware/middlewares.dart';
import 'package:flutter_tinder_template/models/models.dart';
import 'package:flutter_tinder_template/reducers/app_state_reducer.dart';
import 'package:flutter_tinder_template/utils/redux_logging.dart';

class MyApp extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    distinct: true,
    initialState: new AppState.loading(),
    middleware: createAllMiddlewares()
      ..addAll(createLoggingMiddlewares())
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Tinder Template',
        routes: {
          '/': (context) {
            return new StoreBuilder<AppState>(
              onInit: (store) {
                store.dispatch(new LoadAppAction());
              },
              builder: (context, store) {
                return new MainPage();
              }
            );
          },
          '/user-profile-details': (context) {
            return new StoreBuilder<AppState>(
              builder: (context, store) => new ProfileDetailsPage(),
            );
          }
        },
      ),
    );
  }
}

void main() => runApp(new MyApp());
