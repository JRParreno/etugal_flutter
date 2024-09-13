import 'package:etugal_flutter/core/helper/verification_helper.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNav extends StatefulWidget {
  const ScaffoldWithBottomNav({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ScaffoldWithBottomNav> createState() => _ScaffoldWithBottomNavState();
}

class _ScaffoldWithBottomNavState extends State<ScaffoldWithBottomNav> {
  int selectedItemIndex = 0;

  final icons = [
    Icons.home,
    Icons.assignment,
    Icons.add_circle,
    Icons.chat_bubble_outline,
    Icons.person,
  ];

  final titles = [
    'Home',
    'Tasks',
    'Post',
    'Chat',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            items: List.generate(
              icons.length,
              (i) => buildIcon(i),
            ),
            currentIndex: selectedItemIndex,
            onTap: (value) {
              handleonItemTapped(value);
            },
          ),
        ),
      ),
      body: widget.child,
    );
  }

  BottomNavigationBarItem buildIcon(int i) {
    return BottomNavigationBarItem(
      label: titles[i],
      icon: Icon(
        icons[i],
        size: 30,
      ),
    );
  }

  void handleonItemTapped(int index) {
    if (index != 2) {
      setState(() => selectedItemIndex = index);
    }

    switch (index) {
      case 0:
        context.go(AppRoutes.home.path);
        break;
      case 1:
        context.go(AppRoutes.myTaskList.path);
        break;
      case 2:
        VerificationHelper.handleOnTapPostAdd(context: context);
        break;
      case 4:
        context.go(AppRoutes.profile.path);
        break;
      default:
    }
  }
}
