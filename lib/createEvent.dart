import 'dart:io';

import 'package:eventapp/firebase/firebase.dart';
import 'package:eventapp/page/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  FirebaseDB firebase = FirebaseDB();

  String flyer;
  TextEditingController _genre = TextEditingController();
  TextEditingController _place = TextEditingController();
  TextEditingController _artist = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _name = TextEditingController();

  addEvent() {
    firebase.addEvent({
      "Flyer": 'eventpicture/$flyer',
      "Genre": _genre.text,
      "Place": _place.text,
      "artist": _artist.text,
      "date": _date.text,
      "name": _name.text
    });
  }

  PlatformFile file;
  FilePickerResult result;
  File filePicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
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
              height: 45,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _name,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 15, top: 8, right: 15, bottom: 5),
                  filled: true,
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onFieldSubmitted: (String text) async {},
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 45,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _place,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 15, top: 8, right: 15, bottom: 5),
                  filled: true,
                  labelText: 'Place',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onFieldSubmitted: (String text) async {},
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 45,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _date,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 15, top: 8, right: 15, bottom: 5),
                  filled: true,
                  labelText: 'Date',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onFieldSubmitted: (String text) async {},
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 45,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _genre,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 15, top: 8, right: 15, bottom: 5),
                  filled: true,
                  labelText: 'Genre',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onFieldSubmitted: (String text) async {},
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 45,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _artist,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      left: 15, top: 8, right: 15, bottom: 5),
                  filled: true,
                  labelText: 'Artist',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onFieldSubmitted: (String text) async {},
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              padding: EdgeInsets.only(left: 18),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Flyer',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      // side: BorderSide(width: 1),
                                      borderRadius:
                                          new BorderRadius.circular(20.0))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () async {
                            FilePickerResult result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'pdf',
                                'png',
                                'jpeg',
                                'jpg',
                                'svg',
                              ],
                            );

                            if (result != null) {
                              file = result.files.first;

                              filePicked = File(result.files.single.path);

                              flyer = file.name;
                              setState(() {});
                              // String ext = file.extension;

                            }
                          },
                          child: Text('Upload Image',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14))),
                      SizedBox(
                        width: 5,
                      ),
                      Text(flyer ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              // side: BorderSide(width: 1),
                              borderRadius: new BorderRadius.circular(20.0))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () async {
                    await firebase.uploadFileToStorage(filePicked, file.name);
                    await addEvent();
                    _name.clear();
                    _genre.clear();
                    _artist.clear();
                    _date.clear();
                    _place.clear();
                    flyer = '';
                    setState(() {});
                  },
                  child: Text('Submit',
                      style: TextStyle(color: Colors.black, fontSize: 18))),
            )
          ],
        ),
      ),
    );
  }
}
