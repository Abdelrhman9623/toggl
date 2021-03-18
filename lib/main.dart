import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggl/models/responsive.dart';
import 'package:toggl/routes/routes.dart';
import 'package:toggl/screens/HomeScreen.dart';
import 'package:toggl/screens/auth/loginScreen.dart';
import 'package:toggl/services/auth.dart';
import 'package:toggl/services/timeEntries.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, TimeEntriesHandler>(
            create: null,
            update: (context, auth, oldData) => TimeEntriesHandler(
                auth.token, oldData == null ? [] : oldData.timeEntries),
          )
        ],
        child: LayoutBuilder(
          builder: (context, constraints) => OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return Consumer<Auth>(
                builder: (context, auth, _) => MaterialApp(
                  title: 'TOGGL',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: auth.isAuth
                      ? HomeScreen()
                      : FutureBuilder(
                          future: auth.autoLogin(),
                          builder: (context, snapshot) =>
                              snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? LoginScreen()
                                  : auth.isAuth
                                      ? HomeScreen()
                                      : LoginScreen()),
                  routes: customRoutes,
                ),
              );
            },
          ),
        ));
  }
}
