import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Center(child: CircularProgressIndicator()),
              Positioned.fill(child: Center(child: Icon(Icons.alarm)))
            ],
          ),
        ),
      ),
    );
  }
}
