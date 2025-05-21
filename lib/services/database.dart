import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(userInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  Future addUserUploadItem(
    Map<String, dynamic> userInfoMap,
    String uid,
    String itemId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("requests")
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

  Future<Stream<QuerySnapshot>> getAdminRejectedItems(String uid) async {
    return FirebaseFirestore.instance
        .collection("requests")
        .where('status', isEqualTo: 'rejected')
        .where('userId', isEqualTo: uid)
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

  Future approveUserRequestItem(String id, String itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection('requests')
          .doc(itemId)
          .update({'status': 'approved'});
    } catch (e) {
      print(e.toString());
    }
  }

  Future adminRejectRequestItem(String id) async {
    try {
      await FirebaseFirestore.instance.collection("requests").doc(id).update({
        'status': 'rejected',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future rejectUserRequestItem(String id, String itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection('items')
          .doc(itemId)
          .update({'status': 'rejected'});
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateUserPoints(String uid, int newPoints) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        'points': newPoints,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int?> getUserPoints(String docId) async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(docId).get();

      if (userSnapshot.exists) {
        return userSnapshot.get('points');
      } else {
        print("No such documents found.");
        return null;
      }
    } catch (e) {
      print("Error getting user points $e");
      return null;
    }
  }
}
