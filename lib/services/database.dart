import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseMethods {

  Future addUserDetails(Map<String, dynamic> userInfoMap, String id, String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
    .collection('user')
    .doc(id)
        .set(userInfoMap);
  }

  Future addMainUser(String uid,Map<String,dynamic> userInfo) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(userInfo);
  }


  Stream<List<Map<String, dynamic>>> fetchUid(String uid) {
    return fireStore.collection('users').doc(uid).collection('user').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return {
          "name": doc['name'],
          "age": doc['age'],
          "id": doc['id'],
          "location": doc['location'],
        };
      }).toList();
    });
  }




  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>> fetchUserData(String uid) {
    return fireStore.collection('users').doc(uid).collection('user').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        print(doc);
        return {
          "name": doc['name'],
          "age": doc['age'],
          "id": doc['id'],
          "location": doc['location'],
        };
      }).toList();
    });
  }

Future updateEmployeeDetails(String id,String uid, Map<String,dynamic> updateInfo) async{
  return await FirebaseFirestore.instance.collection('users').doc(uid).collection('user').doc(id).update(updateInfo);
}

  Future deleteEmployeeDetails(String uid,String id) async{
    return await FirebaseFirestore.instance.collection('users').doc(uid).collection('user').doc(id).delete();
  }


}
