import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethods {

  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .set(userInfoMap);
  }



  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>> fetchUserData() {
    return fireStore.collection('user').snapshots().map((querySnapshot) {
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

Future updateEmployeeDetails(String id, Map<String,dynamic> updateInfo) async{
  return await FirebaseFirestore.instance.collection('user').doc(id).update(updateInfo);
}

  Future deleteEmployeeDetails(String id) async{
    return await FirebaseFirestore.instance.collection('user').doc(id).delete();
  }


}
