import 'package:flutter/material.dart';
import 'package:sumday/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sumday/providers/place_api.dart';
import 'package:background_fetch/background_fetch.dart';
// ignore: unused_import
import 'dart:async';
// test

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // test
  initLocationState();
  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}
