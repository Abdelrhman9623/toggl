import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggl/helper/http_ex.dart';
import 'package:toggl/helper/url_helper.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  Auth([this._token]);
  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    } else {
      return null;
    }
  }

// privete fun to dont used outside this class
  Future<void> _authantication([String email, String password]) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    try {
      _token = base64Encode(utf8.encode('$email:$password'));
      await http.UrlHelper.getRequest(
        http.UrlHelper.url('me'),
        http.UrlHelper.header('$_token'),
      ).then((value) {
        if (value == 401 || value == 403) {
          print('unauth');
          throw HttpException('$value');
        }
        var userData = json.encode({
          'id': value['data']['id'].toString(),
          'api_token': value['data']['api_token'],
          'fullname': value['data']['fullname'],
          'email': value['data']['email'],
          'timezone': value['data']['timezone'],
          'token': _token
        });
        _pref.setString('userData', userData);
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> login([String email, String password]) async {
    return _authantication(email, password);
  }

// to make user autoLogin in app
  Future<void> autoLogin() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (!_pref.containsKey('userData')) {
      return false;
    }
    var exporToken = json.decode(_pref.get('userData'));
    _token = exporToken['token'];
    notifyListeners();
    return true;
  }

// logout fun if user want to sign in by another account
  Future<void> logout() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _token = null;
    _pref.remove('userData');
    notifyListeners();
  }
}
