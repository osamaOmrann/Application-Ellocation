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
