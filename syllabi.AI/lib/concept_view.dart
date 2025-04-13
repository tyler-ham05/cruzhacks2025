import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import  'package:flutter_markdown/flutter_markdown.dart';

class ConceptView extends StatefulWidget {
  final name; 
  final concept;
  final keywords;
  const ConceptView({super.key, required this.name, required this.concept, required this.keywords});

  @override
  State<ConceptView> createState() => _ConceptViewState();
}

class _ConceptViewState extends State<ConceptView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.name, style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),),
        leading: BackButton(
          onPressed:(){ Navigator.pop(context);},
          
        ),
      ),
      body: FutureBuilder<String>(
      future: aiPrompt(widget.name, widget.concept, widget.keywords),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator()); // or SizedBox(), etc.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Markdown(data: snapshot.data ?? '');
        }
      },
        ),
    );}
}

Future<String> aiPrompt(name, concept, keywords) async {
    String AIinput = "Based off of a class name of $name, and a set of keywords $keywords, generate a summary for the concept in the course $concept while being informative, but consise as possible. Include 1-2 practice problems with answers as well if applicable.";
    return await Gemini.instance.prompt(parts: [Part.text(AIinput)]).then((
      value,
    ) {
      return(value?.output ?? "");
    });
  }