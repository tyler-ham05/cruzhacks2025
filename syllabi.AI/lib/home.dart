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
    var fullData = [];
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
                        
                        
        //print(snapshot);
        if (snapshot.hasData) {
          fullData = snapshot.data as List<Map<String, dynamic>>;
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: false,
              backgroundColor: const Color.fromRGBO(255, 205, 125, 1),
            expandedHeight: 1,
              title: Text(
                "Your Syllabi Dashboard",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                                Padding(padding: const EdgeInsets.all(2),child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('assets/SYLLABI.png'),),),
                                
                              ],
                            ),
                      ),
                    );
                  },
                  icon: Icon(Icons.person),
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
                    child: Card(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)), elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 12),
                            Text(
                              fullData[index]["course_name"],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),),]
                  ),),),);
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
