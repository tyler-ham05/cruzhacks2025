import 'package:flutter/material.dart';
import 'package:flutter_application_1/ai_syllabus_reader.dart';
import 'manual_fields.dart';

class ClassGenerator extends StatelessWidget {
  const ClassGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: (){Navigator.pop(context);}),),
      body: Row(children: [
        GestureDetector(onTap: (){Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AiPrompter(),
                      ),
                    );}, child:Card(child: Text("AI Syllabus Reader"),)),
        GestureDetector(onTap: (){Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EntryFields(),
                      ),
                    );}, child:Card(child: Text("Manual Creator"),)),
      ],)
    );
  }
}