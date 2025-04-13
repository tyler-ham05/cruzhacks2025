import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
// Adjust the path if needed
import 'dart:convert'; //convert library
import 'class_view.dart'; //import class view

class AiPrompter1 extends StatefulWidget {
  const AiPrompter1({super.key});

  @override
  State<AiPrompter1> createState() => _AiPrompter1State();
}

class _AiPrompter1State extends State<AiPrompter1> {
  @override
  String AIinput = "";
  var outputText = "";
  final gemini = Gemini.instance;

  void prompt() {
    print(AIinput);
    setState(() {
      print("Pressed button");

      //------------------added------------------
      Gemini.instance.prompt(parts: [Part.text(AIinput)]).then((value) {
        print(value);
        print("asdfasd");
        var rawJsonString = value?.output;
        print(rawJsonString);
        rawJsonString = rawJsonString
            ?.replaceAll("'''", "")
            .replaceAll("json", "")
            .replaceAll("\n", "");
        Map<String, dynamic> map = jsonDecode(rawJsonString ?? 'bugged out');

        print(map);
        print(map["name"]);
        print("done");
        // Access fields
        outputText = map.toString();

        //need loading circle probably
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("New Syllabus"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.sizeOf(context).height * .75,
              child: SingleChildScrollView(child: Text(outputText)),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'upload your a syllabus as a string',
              ),
              onChanged: (text) {
                AIinput = //name, primer, practice problems with answers
                    "Do NOT use any markdown. Do NOT include triple backticks. Do NOT include the word 'json' in the output. Return ONLY the raw JSON string with no formatting or extra symbols. Given a university course syllabus or description, extract the following details for each concept: 1. Concept Name: The title or name of the concept. 2. Summary of Concept: A one-paragraph summary explaining the concept clearly and concisely. 3. Problems: A list of relevant practice problems for this concept, each with: - Question: A problem related to the concept that a student would solve. - Answer: The solution to the problem, explaining the reasoning or steps involved. Return the data in the following JSON format: { “concepts”: { “Concept Name”: { “summary”: “string”, “problems”: [ { “question”: “string”, “answer”: “string” }, { “question”: “string”, “answer”: “string” } ] } } } } $text";
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
