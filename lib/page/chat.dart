import 'package:eventapp/componentUI/chatMessagePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text(
                  'All Chats',
                  style: GoogleFonts.roboto(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ]),
                ),
              ),
              InkWell(
                child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                      height: 90,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        children: [
                          Image.asset('assets/profilePicture.png'),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'Aninda',
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatMessageBox(
                              name: 'Aninda',
                              numberGroupChat: '001',
                            )),
                  );
                },
              ),
              InkWell(
                child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                      height: 90,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        children: [
                          Image.asset('assets/profilePicture.png'),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'Jamal',
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatMessageBox(
                              name: 'Jamal',
                              numberGroupChat: '002',
                            )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
