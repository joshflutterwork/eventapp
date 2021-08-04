import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/componentUI/cardTicket.dart';
import 'package:eventapp/createEvent.dart';
import 'package:eventapp/firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDB _firebaseDB = FirebaseDB();
  FirebaseAuth auth = FirebaseAuth.instance;
  String userName;

  @override
  void initState() {
    super.initState();
    userName = auth.currentUser.displayName ?? 'User';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateEvent()),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.black87,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      'assets/backgroundimage.png',
                      fit: BoxFit.cover,
                    )),
                Center(
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: Text(
                        'Hello $userName, buat acara konsermu sekarang!',
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
                      )),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, -5), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'All Events',
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
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 50, left: 40, right: 40),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: _firebaseDB.eventStream(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    List<Map<String, dynamic>> data = snapshot
                                        .data.docs
                                        .map((DocumentSnapshot document) =>
                                            document.data())
                                        .toList();
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              width: 400,
                                              child: CardTicket(
                                                  data: data[index]));
                                        });
                                  }
                                  return Card();
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
