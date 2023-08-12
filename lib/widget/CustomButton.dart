import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.6,
      height: MediaQuery.of(context).size.height*0.06,
      child: RawMaterialButton(
        elevation: 0,


        fillColor: Colors.black87,
        splashColor: Colors.teal,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(
                Icons.mail,
                color: Colors.white,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                "SEND  MESSAGE",
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        onLongPress: onPressed,
        shape: const StadiumBorder(),
      ),
    );
  }
}