import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livechat/API/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  static String id = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MessagesAPI messagesAPIAPI = MessagesAPI();
  int userID;
  String userName;
  String messageContent;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID = sharedPreferences.getInt("userID");
    userName = sharedPreferences.getString("username");
    if (userID != null) {
      setState(() {
        userID = userID = sharedPreferences.getInt("userID");
        userName = sharedPreferences.getString("username");
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.builder(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return Directionality(
                                textDirection: userName !=
                                        snapshot
                                            .data[index].messageUser.userName
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: Padding(
                                  padding: userName !=
                                          snapshot
                                              .data[index].messageUser.userName
                                      ? EdgeInsets.only(
                                          bottom: 4,
                                          top: 4,
                                          left: 100,
                                          right: 8)
                                      : EdgeInsets.only(
                                          bottom: 4,
                                          top: 4,
                                          right: 100,
                                          left: 8),
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Colors.grey,
                                          ),
                                          title: Text(
                                            snapshot.data[index].messageUser
                                                .userName,
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 17,
                                                fontFamily: "Cairo"),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              snapshot
                                                  .data[index].messageContent,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontFamily: "Cairo"),
                                            ),
                                          ),
                                        ),
                                        shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        color: userName !=
                                                snapshot.data[index].messageUser
                                                    .userName
                                            ? Colors.white
                                            : Colors.greenAccent,

                                        // color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data.length,
                          ),
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
                                controller: textEditingController,
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
                                      textEditingController.clear();
                                      // scrollController.animateTo(scrollController.position.maxScrollExtent +100, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                      Timer(
                                          Duration(seconds: 1),
                                          () => scrollController.jumpTo(
                                              scrollController
                                                  .position.maxScrollExtent));
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
      ),
    );
  }
}
