import 'package:application_ellocation/apis/apis.dart';
import 'package:application_ellocation/screens/home_side_menu.dart';
import 'package:application_ellocation/screens/search_result_screen.dart';
import 'package:application_ellocation/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('\nUser: ${APIs.auth.currentUser}');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/home_wallpaper.PNG'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: HomeSideMenu(),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Container(
                    padding: EdgeInsets.all(width * .01),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * 200)),
                    child: Icon(
                      Icons.menu,
                      color: Color(0xff81a969),
                      size: width * .07,
                    )),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                  padding: EdgeInsets.all(width * .015),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * .039)),
                  child: Image.asset('assets/images/icon.png')),
            ),
            SizedBox(
              width: width * .05,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return Form(
                      key: formKey,
                      child: AlertDialog(
                        title: Text(AppLocalizations.of(context)!.enter_id),
                        content: TextFormField(
                          controller: idController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.id_required;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.id),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.go),
                            onPressed: () {
                              if (formKey.currentState?.validate() == false) {
                                return;
                              }
                              Navigator.of(dialogContext).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SearchResultScreen(
                                          idController.text.toString())));
                            },
                          ),
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.cancel),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss alert dialog
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height * .11,
                width: height * .11,
                decoration: BoxDecoration(
                    color: Color(0xff81a969),
                    borderRadius: BorderRadius.circular(width * .05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: height * .015,
                    ),
                    Text(
                      AppLocalizations.of(context)!.find_a_device,
                      style:
                          TextStyle(color: Colors.white, fontSize: width * .03),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Settings())),
              child: Container(
                height: height * .11,
                width: height * .11,
                decoration: BoxDecoration(
                    color: Color(0xff81a969),
                    borderRadius: BorderRadius.circular(width * .05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.settings_solid,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: height * .015,
                    ),
                    Text(
                      AppLocalizations.of(context)!.settings,
                      style:
                          TextStyle(color: Colors.white, fontSize: width * .03),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
