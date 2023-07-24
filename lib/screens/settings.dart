import 'package:application_ellocation/providers/language_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              langProvider.changeLanguage(
                  langProvider.currentLanguage == 'en' ? 'ar' : 'en');
            },
            icon: Icon(CupertinoIcons.globe),
            label: Text(
                langProvider.currentLanguage == 'en' ? 'العربية' : 'English')),
      ),
    );
  }
}
