import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonCloseSubmit(
    {bool submitDisable: false,
    Function close,
    Function submit,
    String submitClose: 'Cancel',
    String submitText: 'Submit',
    bool isClose: true,
    bool isSubmit: true}) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isClose
            ? ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(width: 1),
                          borderRadius: new BorderRadius.circular(10.0))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text(submitClose,
                    style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000))),
                onPressed: close)
            : Container(),
        SizedBox(
          width: 10,
        ),
        isSubmit
            ? submitDisable
                ? ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              side: BorderSide(width: 0.5, color: Colors.white),
                              borderRadius: new BorderRadius.circular(10.0))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    child: Text(submitText,
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onPressed: null)
                : ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              side: BorderSide(width: 0.5, color: Colors.white),
                              borderRadius: new BorderRadius.circular(10.0))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink[300]),
                    ),
                    child: Text(submitText,
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onPressed: submit)
            : Container()
      ],
    ),
  );
}
