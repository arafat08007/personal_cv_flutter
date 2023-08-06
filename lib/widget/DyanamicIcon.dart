import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DynamicIcon extends StatelessWidget {
  final String iconName; // Dynamic icon name

  DynamicIcon({ this.iconName});

  @override
  Widget build(BuildContext context) {
    IconData iconData;

    // Map dynamic icon name to IconData
    switch (iconName) {
      case 'fa-cake-candles':
        iconData = Icons.bedroom_baby;
        break;
      case 'fa-school':
        iconData = Icons.school;
        break;
      case 'fa-graduation-cap':
        iconData = Icons.school;
        break;
    // Add more cases for other icons
      default:
        iconData = null;
    }

    if (iconData != null) {
      return Icon(iconData);
    } else {
      return Text('Invalid Icon Name');
    }
  }
}

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Dynamic Icon Example')),
//         body: Center(
//           child: DynamicIconExample(iconName: 'camera'),
//         ),
//       ),
//     ),
//   );
// }
