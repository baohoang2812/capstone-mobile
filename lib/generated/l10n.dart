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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hello`
  String get title {
    return Intl.message(
      'hello',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get PASSWORD {
    return Intl.message(
      'Password',
      name: 'PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get REPORT {
    return Intl.message(
      'Report',
      name: 'REPORT',
      desc: '',
      args: [],
    );
  }

  /// `Branch`
  String get BRANCH {
    return Intl.message(
      'Branch',
      name: 'BRANCH',
      desc: '',
      args: [],
    );
  }

  /// `Violation`
  String get VIOLATION {
    return Intl.message(
      'Violation',
      name: 'VIOLATION',
      desc: '',
      args: [],
    );
  }

  /// `belongs to`
  String get BELONGS_TO {
    return Intl.message(
      'belongs to',
      name: 'BELONGS_TO',
      desc: '',
      args: [],
    );
  }

  /// `Created on`
  String get CREATED_ON {
    return Intl.message(
      'Created on',
      name: 'CREATED_ON',
      desc: '',
      args: [],
    );
  }

  /// `Submitted by`
  String get SUBMITTED_BY {
    return Intl.message(
      'Submitted by',
      name: 'SUBMITTED_BY',
      desc: '',
      args: [],
    );
  }

  /// `Updated on`
  String get UPDATED_ON {
    return Intl.message(
      'Updated on',
      name: 'UPDATED_ON',
      desc: '',
      args: [],
    );
  }

  /// `Regulation`
  String get REGULATION {
    return Intl.message(
      'Regulation',
      name: 'REGULATION',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get DESCRIPTION {
    return Intl.message(
      'Description',
      name: 'DESCRIPTION',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get COMMENTS {
    return Intl.message(
      'Comments',
      name: 'COMMENTS',
      desc: '',
      args: [],
    );
  }

  /// `Evidence`
  String get EVIDENCE {
    return Intl.message(
      'Evidence',
      name: 'EVIDENCE',
      desc: '',
      args: [],
    );
  }

  /// `New violation`
  String get NEW_VIOLATION {
    return Intl.message(
      'New violation',
      name: 'NEW_VIOLATION',
      desc: '',
      args: [],
    );
  }

  /// `Edit violation`
  String get EDIT_VIOLATION {
    return Intl.message(
      'Edit violation',
      name: 'EDIT_VIOLATION',
      desc: '',
      args: [],
    );
  }

  /// `Add image`
  String get ADD_IMAGE {
    return Intl.message(
      'Add image',
      name: 'ADD_IMAGE',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get SUBMIT_BUTTON {
    return Intl.message(
      'Submit',
      name: 'SUBMIT_BUTTON',
      desc: '',
      args: [],
    );
  }

  /// `Latest notification`
  String get HOME_LATEST_NOTIFICATION {
    return Intl.message(
      'Latest notification',
      name: 'HOME_LATEST_NOTIFICATION',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get HOME_SEE_ALL {
    return Intl.message(
      'See all',
      name: 'HOME_SEE_ALL',
      desc: '',
      args: [],
    );
  }

  /// `Report list`
  String get HOME_REPORT_LIST {
    return Intl.message(
      'Report list',
      name: 'HOME_REPORT_LIST',
      desc: '',
      args: [],
    );
  }

  /// `Violation list`
  String get HOME_VIOLATION_LIST {
    return Intl.message(
      'Violation list',
      name: 'HOME_VIOLATION_LIST',
      desc: '',
      args: [],
    );
  }

  /// `Create new`
  String get VIOLATION_SCREEN_CREATE_NEW_BUTTON {
    return Intl.message(
      'Create new',
      name: 'VIOLATION_SCREEN_CREATE_NEW_BUTTON',
      desc: '',
      args: [],
    );
  }

  /// `Create new`
  String get VIOLATION_SCREEN_FETCH_FAIL {
    return Intl.message(
      'Create new',
      name: 'VIOLATION_SCREEN_FETCH_FAIL',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get VIOLATION_SCREEN_RELOAD {
    return Intl.message(
      'Reload',
      name: 'VIOLATION_SCREEN_RELOAD',
      desc: '',
      args: [],
    );
  }

  /// `There is no violations`
  String get VIOLATION_SCREEN_NO_VIOLATIONS {
    return Intl.message(
      'There is no violations',
      name: 'VIOLATION_SCREEN_NO_VIOLATIONS',
      desc: '',
      args: [],
    );
  }

  /// `Branch`
  String get VIOLATION_CREATE_SCREEN_DROPDOWN_FIELD {
    return Intl.message(
      'Branch',
      name: 'VIOLATION_CREATE_SCREEN_DROPDOWN_FIELD',
      desc: '',
      args: [],
    );
  }

  /// `New violation`
  String get VIOLATION_CREATE_SCREEN_ADD_VIOLATION_CARD {
    return Intl.message(
      'New violation',
      name: 'VIOLATION_CREATE_SCREEN_ADD_VIOLATION_CARD',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get VIOLATION_CREATE_MODAL_ADD {
    return Intl.message(
      'Add',
      name: 'VIOLATION_CREATE_MODAL_ADD',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get VIOLATION_SUBMITTED {
    return Intl.message(
      'Submit',
      name: 'VIOLATION_SUBMITTED',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get VIOLATION_STATUS {
    return Intl.message(
      'Status',
      name: 'VIOLATION_STATUS',
      desc: '',
      args: [],
    );
  }

  /// `Opening`
  String get VIOLATION_STATUS_OPENING {
    return Intl.message(
      'Opening',
      name: 'VIOLATION_STATUS_OPENING',
      desc: '',
      args: [],
    );
  }

  /// `Excused`
  String get VIOLATION_STATUS_EXCUSED {
    return Intl.message(
      'Excused',
      name: 'VIOLATION_STATUS_EXCUSED',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get VIOLATION_STATUS_CONFIRMED {
    return Intl.message(
      'Confirmed',
      name: 'VIOLATION_STATUS_CONFIRMED',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get VIOLATION_STATUS_REJECTED {
    return Intl.message(
      'Rejected',
      name: 'VIOLATION_STATUS_REJECTED',
      desc: '',
      args: [],
    );
  }

  /// `There are no reports`
  String get REPORT_SCREEN_NO_REPORTS {
    return Intl.message(
      'There are no reports',
      name: 'REPORT_SCREEN_NO_REPORTS',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get LANGUAGE {
    return Intl.message(
      'Language',
      name: 'LANGUAGE',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get LANGUAGE_VN {
    return Intl.message(
      'Vietnamese',
      name: 'LANGUAGE_VN',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get LANGUAGE_EN {
    return Intl.message(
      'English',
      name: 'LANGUAGE_EN',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get CHANGE_PASSWORD {
    return Intl.message(
      'Change password',
      name: 'CHANGE_PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get LOGOUT {
    return Intl.message(
      'Log out',
      name: 'LOGOUT',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get LOGIN {
    return Intl.message(
      'Log in',
      name: 'LOGIN',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get EDIT {
    return Intl.message(
      'Edit',
      name: 'EDIT',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get DELETE {
    return Intl.message(
      'Delete',
      name: 'DELETE',
      desc: '',
      args: [],
    );
  }

  /// `CREATE NEW SUCCESSFULLY!`
  String get POPUP_CREATE_VIOLATION_SUCCESS {
    return Intl.message(
      'CREATE NEW SUCCESSFULLY!',
      name: 'POPUP_CREATE_VIOLATION_SUCCESS',
      desc: '',
      args: [],
    );
  }

  /// `CREATE NEW FAIL!`
  String get POPUP_CREATE_VIOLATION_FAIL {
    return Intl.message(
      'CREATE NEW FAIL!',
      name: 'POPUP_CREATE_VIOLATION_FAIL',
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
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}