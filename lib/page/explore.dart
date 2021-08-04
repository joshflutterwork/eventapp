import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/componentUI/cardTicket.dart';
import 'package:eventapp/firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  FirebaseDB _firebaseDB = FirebaseDB();
  FirebaseAuth auth = FirebaseAuth.instance;
  String userName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firebaseDB.eventStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      List<Map<String, dynamic>> data = snapshot.data.docs
                          .map((DocumentSnapshot document) => document.data())
                          .toList();
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                                width: 400,
                                child: CardTicket(data: data[index]));
                          });
                    }
                    return Card();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
