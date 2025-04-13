import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


pushToDataBase(String name, List<String>concepts,List<String>keyWords)async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String user = FirebaseAuth.instance.currentUser!.uid;

    // You can optionally enrich or restructure data here if needed
    Map<String, dynamic> data = {
      "course_name": name,
      "concepts": concepts,
      "key_words": keyWords, 
      "dates": [], 
    };

    await firestore.collection(user).doc(name).set(data);
    print("Data pushed successfully!");
  } catch (e) {
    print("Error pushing data: $e");
  }
}