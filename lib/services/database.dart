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

  Future addAdminItem(Map<String, dynamic> itemInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("requests")
          .doc(id)
          .set(itemInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Stream<QuerySnapshot>> getAdminApprovalItems() async {
    return FirebaseFirestore.instance
        .collection("requests")
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  Future adminApproveRequestItem(String id) async {
    try {
      await FirebaseFirestore.instance.collection("requests").doc(id).update({
        'status': 'approved',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future approveUserRequestItem(
    Map<String, dynamic> itemInfoMap,
    String id,
    String itemId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("requests")
          .doc(id)
          .collection('items')
          .doc(itemId)
          .update({'status': 'approved'});
    } catch (e) {
      print(e.toString());
    }
  }
}
