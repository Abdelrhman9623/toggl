import 'package:flutter/material.dart';
import 'package:toggl/screens/HomeScreen.dart';
import 'package:toggl/screens/auth/loginScreen.dart';
import 'package:toggl/screens/timeDetails.dart';

var customRoutes = <String, WidgetBuilder>{
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailseScreen.routeName: (context) => DetailseScreen(),
};
