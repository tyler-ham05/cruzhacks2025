import 'package:flutter/material.dart';
import 'backend_services.dart';
import 'package:intl/intl.dart';

class EntryFields extends StatefulWidget {
  final String name;
  final List<String> concepts;
  final List<String> keywords;
  final List<Map> dates;
  const EntryFields({
    super.key,
    required this.name,
    required this.concepts,
    required this.keywords,
    required this.dates,
  });

  @override
  State<EntryFields> createState() => _EntryFieldsState();
}

class _EntryFieldsState extends State<EntryFields> {
  String name = "";
  List<String> concepts = [];
  List<String> keywords = [];
  List<Map> dates = [];
  String concept = "";
  String keyword = "";
  String date = "";
  DateTime selectedDate = DateTime.now();

  TextEditingController controller0 = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  void _clearTextField(controller) {
    controller.clear(); // 👈 This clears the text field
  }

  @override
  void initState() {
    super.initState();
    name = widget.name;
    concepts = List.from(widget.concepts);
    keywords = List.from(widget.keywords);
    dates = List.from(widget.dates);
    if(name != ""){
      print(name);
      controller0.text = name;
    }
  }

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
            controller: controller0,
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
            controller: controller1,
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
                if (value != "") {
                  concepts.add(value);
                  _clearTextField(controller1);
                }
              });
            },
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (concept != "") {
                  concepts.add(concept);
                  _clearTextField(controller1);
                }
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
          TextFormField(
            controller: controller2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'DFS, Inelastic, Python, etc.',
            ),
            onChanged: (value) {
              keyword = value;
            },
            onFieldSubmitted: (value) {
              setState(() {
                if (value != "") {
                  concepts.add(value);
                  _clearTextField(controller2);
                }
              });
            },
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (concept != "") {
                  keywords.add(keyword);
                  _clearTextField(controller2);
                }
              });
            },
            child: Text("Add"),
          ),
          Text(
            "Important Dates",
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
                children: List.generate(dates.length, (index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "${dates[index]["description"]} @ ${dates[index]["date"]}",
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .5,
                child: TextField(
                  controller: controller4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Midterm, Final, etc.',
                  ),
                  onChanged: (value) {
                    date = value;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .5,
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    selectedDate != null
                        ? DateFormat('MMMM d, y').format(selectedDate)
                        : 'Pick a date',
                  ),
                ),
              ),
            ],
          ),

          TextButton(
            onPressed: () {
              if (date != "") {
                setState(() {
                  _clearTextField(controller4);
                  dates.add({
                    "description": date,
                    "date": DateFormat("MMMM d, y").format(selectedDate),
                  });
                });
              }
            },
            child: Text("Add"),
          ),

          TextButton(
            onPressed: () {
              pushToDataBase(name, concepts, keywords, dates);
            },
            child: Text("Create Course"),
          ),
        ],
      ),
    );
  }
}
