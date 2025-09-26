import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final List<MenuItem>? children;

  MenuItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.children,
  });
}

class DrawerItem extends StatelessWidget {
  final MenuItem item;

  const DrawerItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.children != null && item.children!.isNotEmpty) {
      return ExpansionTile(
        leading: Icon(item.icon),
        title: Text(item.title),
        children: item.children!
            .map((child) => Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListTile(
                    leading: Icon(child.icon),
                    title: Text(child.title),
                    onTap: child.onTap ?? () => Navigator.pop(context),
                  ),
                ))
            .toList(),
      );
    }

    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: item.onTap ?? () => Navigator.pop(context),
    );
  }
}
