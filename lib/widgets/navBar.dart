import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:plasfora_app/pages/acceuil.dart';

class PlasforaBottomNavigationBar extends StatefulWidget {
  final int initialIndex;

  const PlasforaBottomNavigationBar({super.key, this.initialIndex = 0});

  @override
  State<PlasforaBottomNavigationBar> createState() =>
      _PlasforaBottomNavigationBarState();
}

class _PlasforaBottomNavigationBarState
    extends State<PlasforaBottomNavigationBar> {
  late int _currentIndex;

  final List<String> _routes = [
    '/home', // Index 0
    '/chat', //Index 1
    '/map', // Index 2
    '/profile', // Index 3
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        // Navigate to the corresponding page
        Navigator.pushReplacementNamed(context, _routes[index]);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color.fromARGB(255, 62, 101, 240),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: const [
        BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Iconsax.message), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Iconsax.map), label: 'Map'),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.profile_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
