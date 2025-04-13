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
                AIinput =
                    "Do NOT use any markdown. Do NOT include triple backticks. Do NOT include the word json in the output. Return ONLY the raw JSON string, with no formatting or extra symbols. You are an expert education content generator. Given a university course syllabus or description, generate a JSON file with the following structure: { course: <Course Name>, concept_summary: <A concise paragraph summarizing the main topics and goals of the course>, practice_problems: [ { question: <Clear, specific question aligned with a key topic in the course>, answer: <Step-by-step or explanatory solution to the question> } ... ] } Make the summary academic but accessible—1 paragraph max. Include 5–7 practice problems that cover core concepts of the course. Each problem must be relevant, unique, and diverse in difficulty. Each answer must be correct and clear and show reasoning or steps. The input will be a syllabus or course description. The output is just the JSON. Only output the JSON as a string, no explanation. The date structure is with the full month, full day, and full year in one string. the formatReturn only the JSON structure. Do not include triple backticks or any formatting—just the raw JSON$text";
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
