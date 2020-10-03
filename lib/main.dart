import 'package:flutter/material.dart';
import 'package:livechat/screens/login_screen.dart';

void main() => runApp(LiveChat());

class LiveChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     initialRoute: LoginScreen.id,
     routes: {
       LoginScreen.id : (context) => LoginScreen(),
     }
   );
  }
}


