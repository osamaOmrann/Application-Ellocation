// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sing in to continue.`
  String get sign_in_to_continue {
    return Intl.message(
      'Sing in to continue.',
      name: 'sign_in_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get sign_in_with_google {
    return Intl.message(
      'Sign in with Google',
      name: 'sign_in_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Find my device`
  String get find_a_device {
    return Intl.message(
      'Find my device',
      name: 'find_a_device',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Your ID is:`
  String get your_id_is {
    return Intl.message(
      'Your ID is:',
      name: 'your_id_is',
      desc: '',
      args: [],
    );
  }

  /// `Save it to your memory, or to any note outside your device. And don't tell to unreliable people.`
  String
      get save_it_to_your_memory_or_to_any_note_outside_your_device_and_do_not_tell_to_unreliable_people {
    return Intl.message(
      'Save it to your memory, or to any note outside your device. And don\'t tell to unreliable people.',
      name:
          'save_it_to_your_memory_or_to_any_note_outside_your_device_and_do_not_tell_to_unreliable_people',
      desc: '',
      args: [],
    );
  }

  /// `Copy ID`
  String get copy_id {
    return Intl.message(
      'Copy ID',
      name: 'copy_id',
      desc: '',
      args: [],
    );
  }

  /// `Enter ID`
  String get enter_id {
    return Intl.message(
      'Enter ID',
      name: 'enter_id',
      desc: '',
      args: [],
    );
  }

  /// `ID required`
  String get id_required {
    return Intl.message(
      'ID required',
      name: 'id_required',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `go`
  String get go {
    return Intl.message(
      'go',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
