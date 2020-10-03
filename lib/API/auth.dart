import 'package:http/http.dart' as http;

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
        print("login is done");
      }
    else
      {
        print("try agin");
      }

  }
}