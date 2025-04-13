import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'class_generator.dart';
import 'class_view.dart';
import 'backend_services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = pullFromDatabase();
  var tempdata = ["class1", "class2", "class3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No data available'));
                        }
        //print(snapshot);
        List<Map<String, dynamic>> fullData =
                            snapshot.data as List<Map<String, dynamic>>;
        print(fullData);
        return CustomScrollView(
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
                                Padding(padding: const EdgeInsets.all(2)),
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
              itemCount: fullData.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                if (index < fullData.length) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ClassView(data: fullData[index]),
                        ),
                      );
                    },
                    child: Card(child: Text(fullData[index]["course_name"])),
                  );
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
        );
  }),
    );
  }
}
