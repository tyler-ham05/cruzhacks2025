import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
// Adjust the path if needed
import 'dart:convert'; //convert library

class AiPrompter extends StatefulWidget {
  const AiPrompter({super.key});

  @override
  State<AiPrompter> createState() => _AiPrompterState();
}

class _AiPrompterState extends State<AiPrompter> {
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
                    "Please return a class listing based on the provided syllabus in this exact JSON structure: {“name” : string “concepts” : List<string> “keywords” : List<string> “dates” : List<Map<string, string>>} Only output the JSON as a string, no explanation. Return only the JSON structure. Do not include triple backticks or any formatting—just the raw JSON. $text";
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
