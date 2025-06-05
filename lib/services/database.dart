import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<bool> checkUserExists(String uid) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }

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

  Future<Stream<QuerySnapshot>> getUserRedeemRequest(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection('redeems')
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

  Future updateUserPoints({required String uid, required int newPoints}) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        'points': newPoints,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int?> getUserPoints(String uid) async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

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

  Future addUserRedeemPoint(
    Map<String, dynamic> itemInfoMap,
    String id,
    String redeemID,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("redeems")
          .doc(redeemID)
          .set(itemInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  Future addAdminRedeemRequest(
    Map<String, dynamic> itemInfoMap,
    String redeemID,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("redeems")
          .doc(redeemID)
          .set(itemInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }
}
