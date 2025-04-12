import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'ai_syllabus_reader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'class_generator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tempdata = ["class1", "class2", "class3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Your Dashboard", style: TextStyle(fontSize: 30)),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<ProfileScreen>(
                      builder:
                          (context) => ProfileScreen(
                            appBar: AppBar(title: const Text('User Profile')),
                            actions: [
                              SignedOutAction((context) {
                                Navigator.of(context).pop();
                              }),
                            ],
                            children: [
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.all(2),
                              ),
                            ],
                          ),
                    ),
                  );
                },
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          SliverGrid.builder(
            itemCount: tempdata.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              if (index < tempdata.length) {
                return Card(child: Text(tempdata[index]));
              } else {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ClassGenerator(),
                      ),
                    );
                  },
                  child: Card(child: Icon(Icons.add)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
