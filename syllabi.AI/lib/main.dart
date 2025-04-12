import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = 'AIzaSyCkRq8eKTR3ueWQBH7IIcdZQCNFbXwDWAs';

void main() {
  Gemini.init(apiKey: apiKey);
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String AIinput = "";
  String outputText = "";
  final gemini = Gemini.instance;
  
  void prompt() {
    print(AIinput);
    setState(() {
  print("Pressed button");
  
  Gemini.instance.prompt(parts: [
  Part.text(AIinput),
]).then((value) {
  outputText = (value?.output) as String;
  setState(() {
    
  });
}).catchError((e) {
  outputText = ('error ${e}');
});

});
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height:MediaQuery.sizeOf(context).height * .75, child:SingleChildScrollView(child: Text(outputText),),),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter ur AI prompt :D',
              ),
              onChanged: (text){
                AIinput = "The following text after these instructions should be a college syllabus. Your task is to print the concepts that a student will learn in a class with primers for each concept. If for some reason the prompt does not look like a college syllabus, reprompt the user. The content is as follows: ${text}"; 
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: prompt,
        tooltip: "PROMPT",
        child: const Icon(Icons.add),
      ),
    );
  }
}
