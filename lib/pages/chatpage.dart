import 'package:chatapp/components/chat_buble.dart';
import 'package:chatapp/components/textfield_widget.dart';
import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatelessWidget {
  final String receivedEmail;
  final String receiverID;
  Chatpage({
    super.key,
    required this.receivedEmail,
    required this.receiverID,
  });
  final TextEditingController messageController = TextEditingController();

  final ChatServices chatServices = ChatServices();
  final AuthServices authservices = AuthServices();

  //send message

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatServices.sendMessage(receiverID, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(receivedEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  //build messages
  Widget _buildMessagesList() {
    String senderId = authservices.currentUser()!.uid;
    return StreamBuilder(
      stream: chatServices.getMessages(senderId, receiverID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Erro ao carregar os dados'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.blue,
            ),
          );
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    print(data['message']);
    bool isCurrentUser = data['senderID'] == authservices.currentUser()!.uid;
    //align message to the right if it is the current user, otherwise align to the left

    var aliment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: aliment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBuble(
            isCurrentUser: isCurrentUser,
            message: data['message'],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: TextfieldWidget(
            controller: messageController,
            hinttex: 'Escreva sua mensagem',
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
