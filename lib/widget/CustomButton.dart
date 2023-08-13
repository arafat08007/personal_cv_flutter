import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({@required this.onPressed,  this.buttonlebel});
  final GestureTapCallback onPressed;
   String buttonlebel ='Send Message';

  @override
  Widget build(BuildContext context) {
    String btnTxt=buttonlebel;
    return
      SizedBox(
      width: MediaQuery.of(context).size.width*0.3,
      height: MediaQuery.of(context).size.height*0.06,
      child:
      RawMaterialButton(
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
                "Send Message",
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