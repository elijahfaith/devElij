// lib/utils/overlay_manager.dart
import 'package:flutter/material.dart';
import 'package:link_go/app/widgets/sign_in_prompt.dart';
// Store the current overlay entry so we can remove it
OverlayEntry? _currentOverlayEntry;

/// Displays the custom sign-in prompt widget as an overlay at the top of the screen.
void showSignInPromptOverlay(
    BuildContext context, {
      Duration duration = const Duration(seconds: 4), // Default display duration
      required VoidCallback onSignIn,
      required VoidCallback onCreateAccount,
    }) {
  // If an overlay is already showing, remove it first to avoid stacking
  if (_currentOverlayEntry != null) {
    _currentOverlayEntry!.remove();
    _currentOverlayEntry = null;
  }

  _currentOverlayEntry = OverlayEntry(
    builder: (context) {
      return SignInPromptWidget(
        onClose: () {
          // This callback is triggered by SignInPromptWidget when it finishes animating out
          _removeOverlay();
        },
        onSignIn: onSignIn,
        onCreateAccount: onCreateAccount,
        displayDuration: duration, // Pass the duration to the widget
      );
    },
  );

  // Insert the overlay into the Flutter overlay tree
  Overlay.of(context).insert(_currentOverlayEntry!);
}

/// Removes the currently displayed overlay entry.
void _removeOverlay() {
  if (_currentOverlayEntry != null) {
    _currentOverlayEntry!.remove();
    _currentOverlayEntry = null;
  }
}