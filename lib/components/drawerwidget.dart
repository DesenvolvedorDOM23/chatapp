import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/pages/settingspages.dart';
import 'package:flutter/material.dart';

class Drawerwidget extends StatelessWidget {
  const Drawerwidget({super.key});
  void logout() {
    final auth = AuthServices();
    auth.singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    size: 40,
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(
                    Icons.home,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(
                    Icons.settings,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Settingspages(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: ListTile(
              title: const Text("Logout"),
              leading: const Icon(
                Icons.exit_to_app,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
