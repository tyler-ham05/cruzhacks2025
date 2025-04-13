import 'package:flutter/material.dart';

class ClassView extends StatefulWidget {
  final String name;
  const ClassView({super.key, required this.name});

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  List<Map<String, String>> test = [
    {"2-27-2025": "Introduction to AI Exam"},
    {"3-15-2025": "Advanced AI Exam"},
    {"4-10-2025": "AI Ethics Exam"},
    {"5-1-2025": "AI Capstone Project"},
    {"6-1-2025": "AI Final Exam"},
    {"7-1-2025": "AI Group Project"},
    {"8-1-2025": "AI Presentation"},
    {"9-1-2025": "AI Research Paper"},
    {"10-1-2025": "AI Portfolio Review"},
    {"11-1-2025": "AI Internship Application"},
    {"12-1-2025": "AI Job Interview"},
    {"13-1-2025": "AI Networking Event"},
    {"14-1-2025": "AI Conference Attendance"},
    {"15-1-2025": "AI Certification Exam"},
    {"16-1-2025": "AI Industry Trends Report"},
  ];

  List<String> concepts = [
    "Alice Johnson",
    "Bob Smith",
    "Charlie Lee",
    "Diana Carter",
    "Ethan Patel",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];

  @override
  Widget build(BuildContext context) {
    // Flatten test map into entries
    final entries = test.expand((map) => map.entries).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Class Organizer"),
            ),
          ),

          _buildSectionHeader("Concepts To Learn"),
          _buildList(concepts),

          _buildSectionHeader("Keywords"),
          _buildList(concepts), // reuse list if needed

          _buildSectionHeader("Exam Dates"),
          _buildKeyValueList(entries),
        ],
      ),
    );
  }

  /// Widget to create section headers
  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
      ),
    );
  }

  /// Widget to create a list of strings
  SliverList _buildList(List<String> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(items[index]),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }

  /// Widget to create a list from map entries (key-value pairs)
  SliverList _buildKeyValueList(List<MapEntry<String, String>> entries) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final entry = entries[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(entry.value),
              subtitle: Text(entry.key),
            ),
          );
        },
        childCount: entries.length,
      ),
    );
  }
}
