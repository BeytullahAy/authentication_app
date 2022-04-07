import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  final Widget child;
  final Color color;
  // hiç bir şey döndürmeyen özel onpress
  final VoidCallback onPressed;

  const myButton(
      {@required this.color, @required this.onPressed, @required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: RaisedButton(
        // butona tıklandığında kitlenecek ve renginin biraz daha açık olması istiyorum.
        disabledColor: color.withOpacity(0.8),
        color: color,
        onPressed: onPressed,
        child: child,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
