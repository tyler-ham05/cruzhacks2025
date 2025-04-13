import 'package:flutter/material.dart';

class ClassView extends StatefulWidget {
  final String name;
  const ClassView({super.key, required this.name});

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: (){Navigator.pop(context);}),

      ),
      body: Text(widget.name),
    );
  }
}