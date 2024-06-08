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

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Society`
  String get Society {
    return Intl.message(
      'Society',
      name: 'Society',
      desc: '',
      args: [],
    );
  }

  /// `Chat Ai`
  String get Chat_Ai {
    return Intl.message(
      'Chat Ai',
      name: 'Chat_Ai',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get Forgot_Password {
    return Intl.message(
      'Forgot Password',
      name: 'Forgot_Password',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get Login_with_Facebook {
    return Intl.message(
      'Login with Facebook',
      name: 'Login_with_Facebook',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get Login_with_Google {
    return Intl.message(
      'Login with Google',
      name: 'Login_with_Google',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get Dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'Dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Cultures & Content`
  String get Cultures_And_Content {
    return Intl.message(
      'Cultures & Content',
      name: 'Cultures_And_Content',
      desc: '',
      args: [],
    );
  }

  /// `FeedBack`
  String get FeedBack {
    return Intl.message(
      'FeedBack',
      name: 'FeedBack',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get Setting {
    return Intl.message(
      'Setting',
      name: 'Setting',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_information {
    return Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Change_Password {
    return Intl.message(
      'Change Password',
      name: 'Change_Password',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get Change_Language {
    return Intl.message(
      'Change Language',
      name: 'Change_Language',
      desc: '',
      args: [],
    );
  }

  /// `Refugee information`
  String get Change_Refugee {
    return Intl.message(
      'Refugee information',
      name: 'Change_Refugee',
      desc: '',
      args: [],
    );
  }

  /// `Send Feedback`
  String get send_feedback {
    return Intl.message(
      'Send Feedback',
      name: 'send_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Groub Chat`
  String get groub_chat {
    return Intl.message(
      'Groub Chat',
      name: 'groub_chat',
      desc: '',
      args: [],
    );
  }

  /// `Job For You`
  String get job {
    return Intl.message(
      'Job For You',
      name: 'job',
      desc: '',
      args: [],
    );
  }

  /// `Your Applied Jobs`
  String get yourAppliedJobs {
    return Intl.message(
      'Your Applied Jobs',
      name: 'yourAppliedJobs',
      desc: '',
      args: [],
    );
  }

  /// `Request Help`
  String get RequestHelp {
    return Intl.message(
      'Request Help',
      name: 'RequestHelp',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get send_request {
    return Intl.message(
      'Send Request',
      name: 'send_request',
      desc: '',
      args: [],
    );
  }

  /// `Enter your request`
  String get enter_your_request {
    return Intl.message(
      'Enter your request',
      name: 'enter_your_request',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get successfully {
    return Intl.message(
      'Successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get Failed {
    return Intl.message(
      'Failed',
      name: 'Failed',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get FirstName {
    return Intl.message(
      'First Name',
      name: 'FirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get LastName {
    return Intl.message(
      'Last Name',
      name: 'LastName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message(
      'Male',
      name: 'Male',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message(
      'Gender',
      name: 'Gender',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get Female {
    return Intl.message(
      'Female',
      name: 'Female',
      desc: '',
      args: [],
    );
  }

  /// `Date oF Birth`
  String get Birthday {
    return Intl.message(
      'Date oF Birth',
      name: 'Birthday',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Please enter`
  String get Pleaseenter {
    return Intl.message(
      'Please enter',
      name: 'Pleaseenter',
      desc: '',
      args: [],
    );
  }

  /// `Refugee Information`
  String get Refugee_inf {
    return Intl.message(
      'Refugee Information',
      name: 'Refugee_inf',
      desc: '',
      args: [],
    );
  }

  /// `Refugee Card No`
  String get RefugeeCardNo {
    return Intl.message(
      'Refugee Card No',
      name: 'RefugeeCardNo',
      desc: '',
      args: [],
    );
  }

  /// `CV`
  String get CV {
    return Intl.message(
      'CV',
      name: 'CV',
      desc: '',
      args: [],
    );
  }

  /// `No CV uploaded`
  String get NoCVuploaded {
    return Intl.message(
      'No CV uploaded',
      name: 'NoCVuploaded',
      desc: '',
      args: [],
    );
  }

  /// `Pick PDF`
  String get PickPDF {
    return Intl.message(
      'Pick PDF',
      name: 'PickPDF',
      desc: '',
      args: [],
    );
  }

  /// `Card Start Date`
  String get CardStartDate {
    return Intl.message(
      'Card Start Date',
      name: 'CardStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Card End Date`
  String get CardEndDate {
    return Intl.message(
      'Card End Date',
      name: 'CardEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get Country {
    return Intl.message(
      'Country',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `Select a country`
  String get Selectcountry {
    return Intl.message(
      'Select a country',
      name: 'Selectcountry',
      desc: '',
      args: [],
    );
  }

  /// `Profile Page`
  String get ProfilePage {
    return Intl.message(
      'Profile Page',
      name: 'ProfilePage',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get Pleasefillallields {
    return Intl.message(
      'Please fill all fields',
      name: 'Pleasefillallields',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get UserInformation {
    return Intl.message(
      'User Information',
      name: 'UserInformation',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get User_Name {
    return Intl.message(
      'User Name',
      name: 'User_Name',
      desc: '',
      args: [],
    );
  }

  /// `Show Your CV`
  String get ShowYourCv {
    return Intl.message(
      'Show Your CV',
      name: 'ShowYourCv',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get Upload {
    return Intl.message(
      'Upload',
      name: 'Upload',
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
