import 'package:flutter/material.dart';
import 'package:flutter_application_1/concept_view.dart';


class ClassView extends StatefulWidget {
  final Map<String, dynamic> data;
  const ClassView({super.key, required this.data});
  
  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  var name;
  var concepts;
  var keywords;
  var dates;

  @override
  void initState() {
    super.initState();
    name = widget.data["course_name"] as String;
    concepts = widget.data["concepts"];
    keywords = widget.data["key_words"];
    dates = widget.data["dates"];
  }
  Widget build(BuildContext context) {
    // Flatten test map into entries
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 255, 205, 125),
              centerTitle:  false,
          
              title: Text(
                name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),

          _buildSectionHeader("Concepts To Learn"),
          _buildList(concepts),

          _buildSectionHeader("Keywords"),
          _buildKeyWords(keywords), // reuse list if needed

          _buildSectionHeader("Exam Dates"),
          _buildKeyValueList(dates),
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
  SliverList _buildList(items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ConceptView(name: name,concept:items[index],keywords: keywords),
                  ),
                );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              
              child: ListTile(
                title: Text(items[index]),
                
              ),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }

 SliverToBoxAdapter _buildKeyWords(items) {
    return SliverToBoxAdapter(
      child: Center(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(items.length, (index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(items[index]),
                      ),
                    );
                  }),
        ),
      ),
    );
  }

  /// Widget to create a list from map entries (key-value pairs)
  SliverList _buildKeyValueList(entries) {
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
              title: Text(entry["description"]),
              subtitle: Text(entry["date"]),
            ),
          );
        },
        childCount: entries.length,
      ),
    );
  }
}

