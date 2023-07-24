import 'package:application_ellocation/apis/apis.dart';
import 'package:application_ellocation/helpers/dialogs.dart';
import 'package:application_ellocation/screens/auth/login_screen.dart';
import 'package:application_ellocation/screens/users.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeSideMenu extends StatelessWidget {
  const HomeSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(width: double.infinity),
        Container(
          padding: EdgeInsets.symmetric(vertical: height * .03),
          color: Color(0xff81a969),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(height),
                child: CachedNetworkImage(
                    width: height * .055,
                    height: height * .055,
                    imageUrl: APIs.auth.currentUser!.photoURL.toString(),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(CupertinoIcons.person_alt,
                            color: Color(0xff81a969)))),
              ),
              Text(
                APIs.auth.currentUser!.displayName.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * .05),
              )
            ],
          ),
        ),
        SizedBox(
          height: height * .05,
        ),
        Text(
          AppLocalizations.of(context)!.your_id_is,
          style: TextStyle(fontSize: width * .05),
        ),
        SizedBox(
          height: height * .03,
        ),
        Text(
          APIs.user.uid,
          style: TextStyle(fontSize: width * .07),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: height * .05,
        ),
        Text(
          AppLocalizations.of(context)!
              .save_it_to_your_memory_or_to_any_note_outside_your_device_and_do_not_tell_to_unreliable_people,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: height * .05,
        ),
        ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff81a969)),
            ),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: APIs.user.uid));
            },
            icon: Icon(Icons.copy),
            label: Text(AppLocalizations.of(context)!.copy_id)),
        Expanded(
          child: Container(),
        ),
        ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff81a969)),
            ),
            onPressed: () async {
              Dialogs.showProgressBar(context);
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              });
            },
            icon: Icon(Icons.logout),
            label: Text(AppLocalizations.of(context)!.log_out)),
        ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff81a969)),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Users()));
            },
            icon: Icon(CupertinoIcons.person_3_fill),
            label: Text('Users')),
      ],
    );
  }
}
