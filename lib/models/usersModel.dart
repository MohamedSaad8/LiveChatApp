import 'package:livechat/models/messagesModel.dart';

class User {

  int userID;
  String userName;
  String userEmail;
  List<Message> userPosts ;
  User({this.userID, this.userName, this.userEmail , this.userPosts});

}