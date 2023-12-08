import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.beamToNamed('/home');
            },
          ),
          ListTile(
            title: const Text('Books'),
            onTap: () {
              Navigator.pop(context);
              context.beamToNamed('/books');
            },
          ),
          ListTile(
            title: const Text('Books 1'),
            onTap: () {
              Navigator.pop(context);
              context.beamToNamed('/books/1');
            },
          ),
          ListTile(
            title: const Text('Books 1 Author'),
            onTap: () {
              Navigator.pop(context);
              context.beamToNamed('/books/1/Robert A. Heinlein');
            },
          ),
        ],
      ),
    );
  }
}
