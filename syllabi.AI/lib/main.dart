import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'ai_prompter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const apiKey = 'AIzaSyCkRq8eKTR3ueWQBH7IIcdZQCNFbXwDWAs';

void main() async{
  Gemini.init(apiKey: apiKey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
            title: Text("Your Dashboard", style: TextStyle(fontSize: 30),),
            centerTitle: false,
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
                        builder: (context) => const AiPrompter(),
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
