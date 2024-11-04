import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_chat/models/message.dart';

class ChatServices {
  //get instance firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //get instance firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get users by stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firebaseFirestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send a message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user email & Id
    final String currentUserEmail = _auth.currentUser!.email!;
    final String currentUserID = _auth.currentUser!.uid;
    //get time
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //construct chat room id for the tow users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add a message to database

    await _firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    //constructor a chatroom ID for the tow users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firebaseFirestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
