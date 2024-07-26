import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final IconData icon;
  const MyListTile(
      {required this.onTap, required this.text, required this.icon, super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.amber,
      ),
      title: Text(text),
      onTap: onTap,
    );
  }
}
