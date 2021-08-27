import 'package:eventapp/componentUI/buttonClose.dart';
import 'package:eventapp/firebase/firebase.dart';
import 'package:eventapp/page/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTicket extends StatefulWidget {
  final Map<String, dynamic> data;
  String id;

  DetailTicket({this.data, this.id});
  @override
  _DetailTicketState createState() => _DetailTicketState();
}

class _DetailTicketState extends State<DetailTicket> {
  Map<String, dynamic> data;
  FirebaseBloc _firebaseBloc = FirebaseBloc();
  FirebaseDB firebase = FirebaseDB();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = widget.data;
    _firebaseBloc.getDownloadUrl(data['Flyer']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => SimpleDialog(
                          contentPadding: EdgeInsets.all(16),
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text('Delete Event ?'),
                            ),
                            buttonCloseSubmit(
                                submitText: 'Delete',
                                close: () {
                                  Navigator.pop(context);
                                },
                                submit: () async {
                                  await firebase.deleteEvent(widget.id);

                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                })
                          ],
                        ));
              },
              icon: Icon(Icons.delete_outline))
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Detail Ticket'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<Object>(
                  stream: _firebaseBloc.streamDownloadUrl,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(
                        snapshot.data,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 1.5,
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    }
                    return Container();
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Name',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data['name'] ?? '',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Artist',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data['artist'] ?? '',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Genre',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data['Genre'] ?? '',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Place',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data['Place'] ?? '',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Date',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data['date'] ?? '-',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
