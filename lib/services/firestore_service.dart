
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviesapp_zu/models/user_model.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future createNewUser(UserModel data) {
    return users.doc(data.uid).set(data.toJson());
  }

}