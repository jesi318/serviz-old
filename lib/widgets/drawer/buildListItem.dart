import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildListItems(BuildContext context) {
  return Column(
    children: [
      ListTile(
        leading: const Icon(Icons.view_comfy),
        title: const Text('View past Ideas'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.view_comfy),
        title: const Text('Settings'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.logout_rounded),
        title: const Text('Logout'),
        onTap: () {},
      ),
    ],
  );
}
