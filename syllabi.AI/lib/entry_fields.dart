import 'package:flutter/material.dart';

class EntryFields extends StatelessWidget {
  const EntryFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        },),  
      ),
    );
  }
}