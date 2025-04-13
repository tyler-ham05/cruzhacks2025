import 'package:flutter/material.dart';
import 'backend_services.dart';

class EntryFields extends StatefulWidget {
  const EntryFields({super.key});

  @override
  State<EntryFields> createState() => _EntryFieldsState();
}

class _EntryFieldsState extends State<EntryFields> {
  String name = "";
  List<String> concepts = ["beating my meat", "beating it", "super beating it"];
  List<String> keywords = ["goo goo ga", "geee", "goo goo"];
  List<Map> dates = [
    {"description": "midterm", "date": "4/7/2025"},
  ];
  String concept = "";
  String keyword = "";
  String date = "";
  
  TextEditingController _controller = TextEditingController();
  void _clearTextField() {
    _controller.clear(); // 👈 This clears the text field
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Text(
            "Course Name",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Macroeconomics, DSA, etc...',
            ),
            onChanged: (value) {
              name = value; 
            },
          ),
          SizedBox(height: 20),
          Text(
            "Concepts",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
            height: 100,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: List.generate(concepts.length, (index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(concepts[index]),
                    ),
                  );
                }),
              ),
            ),
          ),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'Price Elasticity, Circular Motion, Graph Traversal, etc... ',
            ),
            onChanged: (value) {
              concept = value;
            },
            onFieldSubmitted: (value) {
              setState(() {
                concepts.add(value);
                _clearTextField();
              });
            },
          ),
          TextButton(
            onPressed: () {
              setState(() {
                concepts.add(concept);
                _clearTextField();
              });
            },
            child: Text("Add"),
          ),
          Text(
            "Key Words",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
            height: 100,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: List.generate(keywords.length, (index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(keywords[index]),
                    ),
                  );
                }),
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Ohm\'s law, DFS, BFS, etc.',
            ),
          ),
          TextButton(onPressed: () {}, child: Text("Add")),
          Text(
            "Important Dates",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter ur AI prompt :D',
            ),
          ),
          TextButton(onPressed: () {}, child: Text("Add")),

          TextButton(onPressed: () {
            pushToDataBase( name, concepts, keywords);
          }, child: Text("Create Course")),
        ],
      ),
    );
  }
}
