import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggl/helper/http_ex.dart';
import 'package:toggl/models/responsive.dart';
import 'package:toggl/services/auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isLoading = false;
  Map<String, String> _authData = {'email': '', 'password': ''};
  _submit() async {
    setState(() {
      _isLoading = true;
    });
    if (!_formKey.currentState.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    } on HttpException catch (massege) {
      if (massege.message == '401' || massege.message == '403') {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please check your passwor or email incorrecct')));
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all((SizeConfig.heightMultiplier *
                          SizeConfig.widthMultiplier) +
                      25),
                  child: Image.asset(
                    'assets/image/logo.png',
                    fit: BoxFit.cover,
                    // width: SizeConfig.imageSizeMultiplier * 20,
                    // height: SizeConfig.imageSizeMultiplier * 60,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54)),
                              labelText: 'Email',
                              hintText: 'exmple@exmple.com'),
                          // ignore: missing_return
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'REQUIRED';
                            }
                            if (!val.contains('@') && !val.contains('.')) {
                              return 'INVALID EMAIL ADDRESS';
                            }
                          },
                          onSaved: (val) {
                            _authData['email'] = val.trim();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54)),
                              labelText: 'Password',
                              hintText: 'Enter Your secrete password'),
                          // ignore: missing_return
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'REQUIRED';
                            }
                            if (val.length < 5) {
                              return 'your password too short';
                            }
                          },
                          onSaved: (val) {
                            _authData['password'] = val.trim();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 12.5),
                      alignment: Alignment.center,
                      backgroundColor: Colors.redAccent,
                    ),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _isLoading ? null : _submit,
                  ),
                ),
                _isLoading
                    ? Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Center(child: CircularProgressIndicator()),
                            Positioned.fill(
                                child: Center(child: Icon(Icons.alarm)))
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
