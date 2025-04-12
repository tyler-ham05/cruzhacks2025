import 'package:flutter/material.dart';

class EntryFields extends StatefulWidget {
  const EntryFields({super.key});

  @override
  State<EntryFields> createState() => _EntryFieldsState();
}

class _EntryFieldsState extends State<EntryFields> {
  var concepts = [];
  var keywords = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        },),  
      ),
      body: ListView(children: [
        Text("Course Name", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        TextFormField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Macroeconomics, DSA, etc...',)),
        SizedBox(height: 20,),
        Text("Concepts", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Price Elasticity, Circular Motion, Graph Traversal, etc... ',)),
        TextButton(onPressed: (){}, child: Text("Add")),
        Text("Key Words", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ohm\'s law, DFS, BFS, etc.',)),
        TextButton(onPressed: (){}, child: Text("Add")),   
        Text("Important Dates", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter ur AI prompt :D',)),
        TextButton(onPressed: (){}, child: Text("Add")),

        TextButton(onPressed: (){}, child: Text("Create Course")),
      ],)
    );
  }
}