import 'package:livechat/models/usersModel.dart';

class Message
{
  int messageID;
  String messageContent ;
  User messageUser ;
  Message({this.messageID, this.messageContent, this.messageUser});

}