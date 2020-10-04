import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livechat/API/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  static String id = "ChatScreen" ;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  MessagesAPI messagesAPIAPI = MessagesAPI();
  int userID;
  String messageContent;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  getUserID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID = sharedPreferences.getInt("userID");
    if (userID != null) {
      setState(() {
        userID = userID = sharedPreferences.getInt("userID");
      });
    }
  }

  @override
  void initState() {
    getUserID();
    super.initState();
  }
  bool isMe = true ;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 70,
                color: Colors.grey[300],
                child: StreamBuilder(
                  stream: messagesAPIAPI.getData(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                            child: Column(
                              children: <Widget>[
                                Card(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: CircleAvatar(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: Colors.grey,
                                        ),
                                        title: Text(
                                          snapshot.data[index].messageUser.userName,
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 17,
                                            fontFamily: "Cairo"
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Text(
                                              snapshot.data[index].messageContent ,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontFamily: "Cairo"
                                            ),
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),
                                  shape: Border.all(
                                    color: Colors.green[900],
                                  ),
                                 // color: Colors.red,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data.length,
                      );
                    } else
                      return Container(
                        child: Text("no data in snapshot"),
                      );
                  },
                ),
              ),
              Positioned(
                bottom: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.camera_alt), onPressed: () {}),
                      Expanded(
                        child: Form(
                          key: _globalKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onSaved: (value) {
                                messageContent = value;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    _globalKey.currentState.save();
                                    messagesAPIAPI.addMessage(
                                        messageContent: messageContent,
                                        userID: userID);
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.all(5),
                                hintText: "اكتب رسالتك هتا . . .",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
