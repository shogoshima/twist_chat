import 'package:flutter/material.dart';

class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      groupAlignment: -1,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          selectedIcon: Icon(Icons.chat_outlined),
          icon: Icon(Icons.chat),
          label: Text('Chats'),
        ),
        NavigationRailDestination(
          selectedIcon: Icon(Icons.settings_outlined),
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
