import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ListMessage extends StatefulWidget {
  @override
  _ListMessageState createState() => _ListMessageState();

  final Map<String, dynamic> data;

  ListMessage({this.data});
}

class _ListMessageState extends State<ListMessage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final radius = widget.data['sender'] != '1'
        ? BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          );

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      alignment: widget.data['sender'] == '1'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              // constraints: BoxConstraints(minWidth: 50, maxWidth: 250),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 2),
              decoration: widget.data['sender'] == 1
                  ? BoxDecoration(
                      color:
                          widget.data['sender'] == auth.currentUser.phoneNumber
                              ? Colors.grey
                              : Colors.white,
                      borderRadius: radius,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFFFFF),
                          const Color(0xFFFFFFFF),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(2.0, 2.5),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 0,
                        ),
                      ],
                    )
                  : BoxDecoration(
                      color: widget.data['sender'] == '1'
                          ? Colors.grey[400]
                          : Colors.white,
                      borderRadius: radius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 0,
                        ),
                      ],
                    ),
              child: Text(widget.data['message'] ?? '')),
        ],
      ),
    );
  }
}
