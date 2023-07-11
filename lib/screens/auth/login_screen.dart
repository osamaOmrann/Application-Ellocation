import 'dart:io';

import 'package:application_ellocation/apis/apis.dart';
import 'package:application_ellocation/helpers/dialogs.dart';
import 'package:application_ellocation/providers/language_provider.dart';
import 'package:application_ellocation/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/stars.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * .045, horizontal: width * .053),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        langProvider.changeLanguage(
                            langProvider.currentLanguage == 'en' ? 'ar' : 'en');
                      },
                      child: Icon(
                        CupertinoIcons.globe,
                        color: Colors.white,
                        size: width * .083,
                      ))
                ],
              ),
            ),
            SizedBox(height: height * .1),
            Container(
              padding: EdgeInsets.all(height * .03),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * .05)),
              child: Image.asset(
                'assets/images/icon.png',
                width: width * .17,
                height: width * .17,
              ),
            ),
            SizedBox(height: height * .15),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: langProvider.currentLanguage == 'en'
                        ? BorderRadius.only(
                            topRight: Radius.circular(width * .25))
                        : BorderRadius.only(
                            topLeft: Radius.circular(width * .25))),
                child: Padding(
                  padding: EdgeInsets.all(width * .15),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                            fontSize: width * .075,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppLocalizations.of(context)!.sign_in_to_continue,
                        style: TextStyle(
                            fontSize: width * .03, color: Colors.grey),
                      ),
                      SizedBox(
                        height: height * .1,
                      ),
                      InkWell(
                        onTap: () => _handleGoogleButtonClic().then((user) {
                          print('\nUser: ${user.user}');
                          print(
                              '\nUserAdditionalInfo: ${user.userAdditionalInfo}');
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        }),
                        child: Container(
                          padding: EdgeInsets.all(width * .01),
                          color: Color(0xffe1ecf6),
                          child: Container(
                            padding: EdgeInsets.all(width * .03),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(width * .03)),
                            child: Row(children: [
                              Image.asset(
                                'assets/images/google.png',
                                width: width * .07,
                                height: width * .07,
                              ),
                              SizedBox(
                                width: width * .09,
                              ),
                              Text(AppLocalizations.of(context)!
                                  .sign_in_with_google)
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleGoogleButtonClic() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if (user != null) {
        print('\nUser: ${user.user}');
        print('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      print('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Something went wrong!');
      return null;
    }
  }
}
