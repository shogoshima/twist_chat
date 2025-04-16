import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String username;
  final String photoUrl;

  const ProfileCard({
    super.key,
    required this.name,
    required this.username,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(photoUrl), radius: 40),
            const SizedBox(height: 5),
            Text(name),
            const SizedBox(height: 2),
            Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
