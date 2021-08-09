import 'package:eventapp/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTicket extends StatefulWidget {
  Map<String, dynamic> data;

  CardTicket({this.data});
  @override
  _CardTicketState createState() => _CardTicketState();
}

class _CardTicketState extends State<CardTicket> {
  Map<String, dynamic> data;
  FirebaseBloc _firebaseBloc = FirebaseBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = widget.data;
    _firebaseBloc.getDownloadUrl(data['Flyer']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 1,
        color: Colors.grey,
        child: Container(
          child: Row(
            children: [
              Container(
                child: StreamBuilder<Object>(
                    stream: _firebaseBloc.streamDownloadUrl,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0)),
                          child: Image.network(
                            snapshot.data,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container();
                      }
                      return Container();
                    }),
              ),
              Container(
                  height: 180,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 180,
                            child: Text(
                              data['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 180,
                            child: Text(
                              'Artist',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            width: 180,
                            child: Text(
                              data['artist'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        width: 180,
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                            Text(
                              data['date'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
