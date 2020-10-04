import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Auth
{
  String url = "http://10.0.2.2:1337/auth/local" ;
  userLogin(String email , String password)async{
    Map<String,String> userData = {
      "identifier" : email,
      "password" : password
    };
    var response = await http.post(url , body: userData);
    if(response.statusCode == 200)
      {
        var responseBody = jsonDecode(response.body);
        SharedPreferences sharedPreference = await SharedPreferences.getInstance();
        sharedPreference.setString("username", responseBody["user"]["username"]);
        sharedPreference.setString("email", responseBody["user"]["email"]);
        sharedPreference.setInt("userID", responseBody["user"]["id"]);
        print("Logined done");
        return true;
      }
    else
      {
        print("Logined faild");
        return false;
      }

  }
}