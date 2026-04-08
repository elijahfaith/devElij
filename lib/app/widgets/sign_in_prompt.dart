// lib/widgets/sign_in_prompt_widget.dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/utils/app_colors.dart'; // Required for Timer

class SignInPromptWidget extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onSignIn;
  final VoidCallback onCreateAccount;
  final Duration displayDuration;

  const SignInPromptWidget({
    Key? key,
    required this.onClose,
    required this.onSignIn,
    required this.onCreateAccount,
    this.displayDuration = const Duration(seconds: 6), // Default display duration
  }) : super(key: key);

  @override
  State<SignInPromptWidget> createState() => _SignInPromptWidgetState();
}

class _SignInPromptWidgetState extends State<SignInPromptWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation speed
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.2), // Start slightly above
      end: Offset.zero, // End at its natural position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(); // Start fade-in and slide-down animation

    // Start auto-dismiss timer
    _dismissTimer = Timer(widget.displayDuration, () {
      _controller.reverse().then((_) {
        // After fade-out animation completes, call onClose to remove the OverlayEntry
        widget.onClose();
      });
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel(); // Cancel any active timer
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  // Handles both manual close and button presses (dismisses the widget)
  void _handleDismiss() {
    _dismissTimer?.cancel(); // Stop auto-dismiss if user interacts
    _controller.reverse().then((_) {
      widget.onClose(); // Inform the overlay manager to remove the widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Ensures content doesn't overlap status bar
      child: Align(
        alignment: Alignment.topCenter,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material( // Use Material for elevation and shape
                borderRadius: BorderRadius.circular(16.0),
                elevation: 4.0, // Shadow for the card
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Wrap content tightly
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon on the left
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors
                                  .primaryColor
                                  .withOpacity(0.1),
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/images/noIdLogIcon.svg')
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Text content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign in to unlock all features',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp
                                  ),
                                ),
                                 SizedBox(height: 4.h),
                                Text(
                                  'Create listings, save favorites, and manage orders',
                                  style: GoogleFonts.roboto(
                                    color: AppColors.lightTextBlack,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Close button
                          InkWell(
                            onTap: _handleDismiss,
                            child: const Icon(Icons.close, size: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _handleDismiss();
                                widget.onSignIn();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _handleDismiss();
                                widget.onCreateAccount();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                side: const BorderSide(color: AppColors.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Create account',
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}