// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
//   final VoidCallback? onNotificationPressed;
//   final VoidCallback? onProfilePressed;

//   const TopNavBar({
//     super.key,
//     this.onNotificationPressed,
//     this.onProfilePressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       actions: [
//         IconButton(
//           icon: const Icon(Iconsax.notification, color: Colors.white),
//           onPressed: onNotificationPressed ?? () {},
//         ),
//         IconButton(
//           icon: const Icon(Iconsax.profile_circle, color: Colors.white),
//           onPressed: onProfilePressed ?? () {},
//         ),
//         const SizedBox(width: 10),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
