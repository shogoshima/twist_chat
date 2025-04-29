import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twist_chat/providers/auth.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the state of the GoogleAuth provider
    final authState = ref.watch(authProvider);

    // Determine if the provider is currently in a loading state.
    // Using maybeWhen lets you easily extract the loading condition.
    final isSigningIn = authState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return ElevatedButton(
      // Disable the button when signing in (loading state)
      onPressed:
          isSigningIn
              ? null
              : () async {
                try {
                  await ref.read(authProvider.notifier).login();
                } catch (error) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error signing in: $error')),
                  );
                }
              },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Prevent stretching to full width
          children: [
            // If signing in, show a CircularProgressIndicator; otherwise, show the Google logo.
            if (isSigningIn)
              const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Image.asset('assets/google.png', height: 24, width: 24),
            const SizedBox(width: 12),
            const Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
