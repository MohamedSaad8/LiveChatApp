import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livechat/API/auth.dart';

class LoginScreen extends StatelessWidget {
  static String id = "LoginScreen";
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Auth auth =Auth();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            pageTitle(screenWidth, screenHeight),
            Container(
              width: screenWidth,
              height: screenHeight / 5,
              //color: Colors.red,
              child: Center(
                child: CircleAvatar(
                  radius: screenWidth / 10.8,
                  backgroundColor: Colors.grey[500],
                  child: Icon(
                    Icons.person,
                    size: screenWidth / 5.4,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            loginForm(),
            SizedBox(
              height: screenWidth / 5.4,
            ),
            loginButton(screenWidth),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Padding loginButton(double screenWidth) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: InkWell(
              onTap: () {
                _globalKey.currentState.validate();
                _globalKey.currentState.save();
                auth.userLogin(email, password);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: Colors.grey),
                  ],
                ),
                padding: EdgeInsets.all(15),
                width: screenWidth,
                child: Center(
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
  }

  Stack pageTitle(double screenWidth, double screenHeight) {
    return Stack(
            children: <Widget>[
              Container(
                width: screenWidth,
                height: screenHeight / 6,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print(screenWidth);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Padding loginForm() {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              autovalidate: false,
              key: _globalKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (value){email =value ;},
                    validator: (value){
                      if(value.isEmpty)
                      // ignore: missing_return
                      return "Email Adress required feild" ;
                    },
                    decoration: InputDecoration(
                      labelText: "E-mail Address",
                      labelStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 20),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value){password =value;},
                    validator: (value){
                      if(value.isEmpty)
                        // ignore: missing_return
                        return "password required feild" ;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey[500],
                      ),
                      labelText: "Password",
                      labelStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 20),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
