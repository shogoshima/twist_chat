import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twist_chat/models/models.dart';

Future<void> showUserDialog(BuildContext context, Profile user) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('User', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              radius: 50,
            ),
            const SizedBox(height: 10),
            Text(user.displayName),
            const SizedBox(height: 4),
            Text(
              user.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    },
  );
}
