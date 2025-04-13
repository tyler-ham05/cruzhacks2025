import 'package:flutter/material.dart';
import 'package:flutter_application_1/ai_syllabus_reader.dart';
import 'manual_fields.dart';
import 'package:flutter_application_1/ai_ProbFunc.dart';

class ClassGenerator extends StatelessWidget {
  const ClassGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false,  title: Text('Upload New Class' ,style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  ),),
          backgroundColor: Color.fromARGB(255, 255, 205, 125), leading: BackButton(onPressed: (){Navigator.pop(context);}),),
      body: Center(
        
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Column 1
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AiPrompter(),
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: MediaQuery.sizeOf(context).height * .6,
                child: Card(
                  elevation: 4,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.all(12),
                  shadowColor: Colors.grey,
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "Upload from syllabus",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Column 2
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EntryFields(name: "",concepts: [],keywords: [],dates:[],),
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: MediaQuery.sizeOf(context).height * .6,
                child: Card(
                  elevation: 4,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.all(12),
                  shadowColor: Colors.grey,
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "Create Class From Scratch",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    ],
  ),
),
    );
  }
}