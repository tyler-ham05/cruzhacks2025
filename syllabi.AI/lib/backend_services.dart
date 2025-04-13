import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


pushToDataBase(String name, List<String>concepts,List<String>keyWords, dates)async {
  try {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String user = FirebaseAuth.instance.currentUser!.uid;


    Map<String, dynamic> data = {
      "course_name": name,
      "concepts": concepts,
      "key_words": keyWords, 
      "dates": dates, 
    };

    await firestore.collection(user).doc(name).set(data);
    print("Data pushed successfully!");
  } catch (e) {
    print("Error pushing data: $e");
  }
}

pullFromDatabase() async{
  try{
    final String user = FirebaseAuth.instance.currentUser!.uid;
     CollectionReference data = FirebaseFirestore.instance.collection(user);
    QuerySnapshot querySnapshot = await data.get();
    if (querySnapshot.docs.isEmpty) {
    return null;
  }
  return querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();
  }
  catch(e){
    print("evil things happened");
    return null;
  }
}