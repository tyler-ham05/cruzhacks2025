import 'package:flutter/material.dart';
import 'auth_gate.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'ai_prompter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const apiKey = 'AIzaSyCkRq8eKTR3ueWQBH7IIcdZQCNFbXwDWAs';

void main() async{
  Gemini.init(apiKey: apiKey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AuthGate(),
    );
  }
}

