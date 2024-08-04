import 'package:chatapp/components/drawerwidget.dart';
import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/pages/chatpage.dart';
import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final ChatServices chatServices = ChatServices();
  final AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const Drawerwidget(),
      body: _buildUSerList(),
    );
  }

  Widget _buildUSerList() {
    return StreamBuilder(
      stream: chatServices.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Erro ao carregar os dados',
            ),
          );
        }
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userdata) => _buildUserListItem(userdata, context),
                )
                .toList(),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userdata, BuildContext context) {
    if (userdata['email'] != authServices.currentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: UserTile(
          text: userdata['email'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chatpage(
                  receivedEmail: userdata['email'],
                  receiverID: userdata['id'],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
