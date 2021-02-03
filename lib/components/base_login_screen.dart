import 'package:flutter/material.dart';

class BaseLoginScreen extends StatelessWidget {
  final Widget child;
  final String title;

  BaseLoginScreen({
    @required this.child,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/graphism.png',
                      height: 50,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                child: Text(
                  this.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                width: double.infinity,
              ),
            ),
            this.child
          ],
        ),
      ),
    );
  }
}
