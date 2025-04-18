import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'manual_fields.dart';
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

  Future<Map<String, dynamic>> aiPrompt() async {
    return await Gemini.instance.prompt(parts: [Part.text(AIinput)]).then((
      value,
    ) {
      print(value);
      var rawJsonString = value?.output;
      print(rawJsonString);
      rawJsonString = cleanJson(rawJsonString as String);
      try {
        Map<String, dynamic> map = jsonDecode(rawJsonString ?? 'bugged out');

        print(map);
        print(map["name"]);
        print("done");
        return map;
      } catch (e) {
        print("JSON PARSING ERROR $e");
        return {"name": "FAILED"};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 205, 125),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text(
          "Syllabi AI Helper",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                autocorrect: true,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'upload your a syllabus as a string',
                ),
                onChanged: (text) {
                  AIinput =
                      "Please return a class listing based on the provided syllabus in this exact JSON structure: {“name” : string “concepts” : List<string> “keywords” : List<string> “dates” : List<Map<string description, string date>> } Only output the JSON as a string, no explanation. For the date structure it with the full month full day, full year in one string. Return only the JSON structure. Do not include triple backticks or any formatting—just the raw JSON. I repeat, return just the raw JSON string with no code block, markdown, or extra characters — only valid JSON. : $text";
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
          Map<String, dynamic> value = await aiPrompt();
          print(value);
          if (value["name"] != "FAILED") {
            print("valid!");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => EntryFields(
                      name: value["name"],
                      concepts: List<String>.from(value["concepts"]),
                      keywords: List<String>.from(value["keywords"]),
                      dates: List<Map<String, String>>.from(
                        value["dates"].map((e) => Map<String, String>.from(e)),
                      ),
                    ),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => const EntryFields(
                      name: "",
                      concepts: [],
                      keywords: [],
                      dates: [],
                    ),
              ),
            );
          }
        },
        tooltip: "Upload",
        child: const Icon(Icons.upload),
      ),
    );
  }
}

String cleanJson(String input) {
  final regex = RegExp(r"^(```|''')json\n?|(```|''')$");
  return input.replaceAll(regex, '').trim();
}
