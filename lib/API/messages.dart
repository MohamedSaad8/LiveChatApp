import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:livechat/models/messagesModel.dart';
import 'package:livechat/models/usersModel.dart';

class MessagesAPI {
  String messagesURL = "http://10.0.2.2:1337/messages";

  Future<List<Message>> getAllMessages() async {
    var response = await http.get(messagesURL);
    var data = jsonDecode(response.body);
    List<Message> messages = [];

    for (var message in data) {

      messages.add(
        Message(
          messageID: message["id"],
          messageContent: message["messageContent"],
          messageUser: User(userName: message["user"]["username"]),

        ),
      );
    }

    return messages;
  }

  Stream<List<Message>> getData (Duration duration) async* {

    while(true)
    {
      await Future.delayed(duration);
      yield await getAllMessages();
    }

  }

  addMessage({String messageContent , int userID}) async{

    var data = {
      "messageContent" : messageContent ,
      "user": "$userID"
    };

    var response = await http.post(messagesURL ,body: data);
    if(response.statusCode == 200)
    {
      print("poste add operation done");
    }
    else
    {
      print("not complete");
    }

  }
}