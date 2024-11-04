import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_chat/auth/Auth_service.dart';
import 'package:room_chat/components/my_textfield.dart';
import 'package:room_chat/services/chat/chat_services.dart';
import 'package:room_chat/themes/theme_provider.dart';

class ChatPage extends StatelessWidget {
  String emailUser;
  String receiverID;

  ChatPage({super.key, required this.receiverID, required this.emailUser});

  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    //if there is something inside the textField
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          receiverID, _messageController.text.toString());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text(emailUser),
      ),
      body: Column(
        children: [
          //display all message
          Expanded(child: _buildMessageList()),
          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessage(receiverID, senderID),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Center(child: Text("Error"));
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("loading..."));
        }

        //return list view
        return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc, context))
                .toList());
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc, context) {
    bool isDark = Provider
        .of<ThemeProvider>(context, listen: false)
        .isDarkMode;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;
    var alignment =
    isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isCurrentUser ? (isDark ? Colors.green
                        .shade600 :Colors.green.shade500) : (isDark ? Colors.grey
                        .shade800 :Colors.grey.shade200)),
                child: Text(data["message"],style: TextStyle(
                    color: isCurrentUser ? Colors.white : (isDark ? Colors.white:Colors.black)),
                ),),
          ],
        ));
  }

  //

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
                  hint: 'type your message..',
                  radius: 18.0,
                  isPassword: false,
                  controller: _messageController,
                  keyboardType: TextInputType.text)),
          Container(
              decoration:
              BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send)))
        ],
      ),
    );
  }
}
