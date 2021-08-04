import 'package:eventapp/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset('assets/logo.png'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        primary: Colors.white,
                        shadowColor: Colors.white),
                    onPressed: () async {
                      _currentUser = await _googleSignIn.signIn();

                      final GoogleSignInAuthentication googleAuth =
                          await _currentUser.authentication;

                      // Create a new credential
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );

                      // Once signed in, return the UserCredential
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      if (_currentUser != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigatorButton()),
                        );
                      }
                      print(_currentUser.displayName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/google.png',
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.quicksand(
                                letterSpacing: 2.5,
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
