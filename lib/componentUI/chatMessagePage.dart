import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/componentUI/listMessage.dart';
import 'package:eventapp/firebase/firebase.dart';
import 'package:flutter/material.dart';

class ChatMessageBox extends StatefulWidget {
  final String numberGroupChat;
  final String name;

  ChatMessageBox({this.numberGroupChat, this.name});
  @override
  _ChatMessageBoxState createState() => _ChatMessageBoxState();
}

class _ChatMessageBoxState extends State<ChatMessageBox> {
  FirebaseDB firebase = FirebaseDB();

  onSendMessage(String text) {
    firebase.addChat(widget.numberGroupChat, {
      "message": _controllerMessage.text,
      "sender": "1",
      "created_at": FieldValue.serverTimestamp(),
    });
  }

  Widget messageContent(context, List data) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      // height: 247,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.black),
      child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListMessage(
              data: data[index],
            );
          }),
    ));
  }

  TextEditingController _controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(widget.name),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            Container(),
            StreamBuilder<QuerySnapshot>(
                stream: firebase.streamChatMessage(widget.numberGroupChat),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> data = snapshot.data.docs
                        .map((DocumentSnapshot document) => document.data())
                        .toList();

                    return messageContent(context, data);
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            Column(
              children: [
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            // focusNode: _focusNode,
                            controller: _controllerMessage,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            // minLines: 5,
                            // textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              filled: true,
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 20),
                              hintText: 'Ketik chat di sini',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.grey[350], width: 1.0),
                              ),
                            ),
                            // controller: _textController,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                          // padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Container(
                              child: Icon(
                                Icons.send_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          await onSendMessage(_controllerMessage.text);
                          _controllerMessage.clear();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
