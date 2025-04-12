import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AiPrompter extends StatefulWidget {
  const AiPrompter({super.key});

  @override
  State<AiPrompter> createState() => _AiPrompterState();
}

class _AiPrompterState extends State<AiPrompter> {
  @override
  String AIinput = "";
  String outputText = "";
  final gemini = Gemini.instance;

  void prompt() {
    print(AIinput);
    setState(() {
      print("Pressed button");

      Gemini.instance
          .prompt(parts: [Part.text(AIinput)])
          .then((value) {
            outputText = (value?.output) as String;
            setState(() {});
          })
          .catchError((e) {
            outputText = ('error ${e}');
          });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: BackButton(onPressed: (){Navigator.pop(context);},),
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
                hintText: 'Enter ur AI prompt :D',
              ),
              onChanged: (text) {
                AIinput =
                    "The following text after these instructions should be a college syllabus. Your task is to print the concepts that a student will learn in a class with primers for each concept. If for some reason the prompt does not look like a college syllabus, reprompt the user. The content is as follows: $text";
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
