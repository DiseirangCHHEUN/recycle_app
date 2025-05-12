import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .set(userInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  Future addUserUplaodItem(
    Map<String, dynamic> userInfoMap,
    String id,
    String itemId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("items")
          .doc(itemId)
          .set(userInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  Future addAdminItem(Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("requests")
          .doc(id)
          .set(userInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }
}
