import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_chat/%20modules/setting_page.dart';

import '../auth/Auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    size: 60,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                  ),
                )),


            Column(
              children: [
                //home list
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    title: const Text('H O M E'),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),


                //setting list
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    title: const Text('S E T T I N G'),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(),));
                    },
                  ),
                ),
              ],
            ),


            //log out list
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: const Text('L O G O U T'),
                leading: const Icon(Icons.logout),
                onTap: logout,
              ),
            ),
          ],
        ),
      ),
    );
  }



  void logout() {
    final AuthService authService = AuthService();
    authService.signOut();
  }
}
