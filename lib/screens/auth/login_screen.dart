/*
import 'package:application_ellocation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            AppLocalizations.of(context)!.welcome_to_application_ellocation),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            top: height * .15,
            right: _isAnimated ? width * .25 : -width * .5,
            width: width * .5,
            duration: Duration(seconds: 1),
            child: Image.asset('assets/images/icon.png'),
          ),
          Positioned(
            bottom: height * .15,
            left: width * .05,
            width: width * .9,
            height: height * .07,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 219, 255, 178),
                  shape: StadiumBorder(),
                  elevation: 1),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              icon: Image.asset(
                'assets/images/google.png',
                height: height * .03,
              ),
              label: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: 'MyArabicFont',
                        color: Colors.black,
                        fontSize: 16),
                    children: [
                      TextSpan(text: 'Login With '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/

import 'package:application_ellocation/providers/language_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                      Container(
                        padding: EdgeInsets.all(width * .01),
                        color: Color(0xffe1ecf6),
                        child: Container(
                          padding: EdgeInsets.all(width * .03),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * .03)),
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
}
