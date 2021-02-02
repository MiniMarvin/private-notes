import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final Function() action;
  final String leftText;
  final String actionText;
  final String rightText;

  CustomTextButton({
    @required this.action,
    @required this.actionText,
    this.leftText = '',
    this.rightText = '',
  });

  @override
  State<StatefulWidget> createState() => CustomTextButtonState();
}

class CustomTextButtonState extends State<CustomTextButton> {
  double opacity = 1;
  Duration duration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          opacity = 0.4;
        });
      },
      onTapCancel: () {
        setState(() {
          opacity = 1.0;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          opacity = 1.0;
        });
      },
      onTap: () {
        setState(() {
          opacity = 0.4;
        });
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            opacity = 1.0;
          });
        });
        this.widget.action();
      },
      child: AnimatedOpacity(
        opacity: this.opacity,
        duration: this.duration,
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: this.widget.leftText),
              TextSpan(
                text: this.widget.actionText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).buttonColor,
                ),
              ),
              TextSpan(text: this.widget.rightText),
            ],
          ),
        ),
      ),
    );
  }
}
