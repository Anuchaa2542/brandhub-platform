// features/splash/presentation/pages/splash_page.dart
import 'dart:async';
import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_sizes.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:brandhub/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();

    _startApp();
  }

  void _startApp() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(AppRoutes.login);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.storefront,
                color: Colors.white,
                size: AppSizes.iconLg * 2,
              ),
              SizedBox(height: AppSizes.lg),
              AppText(
                "BrandHub",
                style: TextStyle(
                  fontSize: AppSizes.displayMd,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: AppSizes.sm),
              AppText(
                "Smart Business Platform",
                style: TextStyle(
                  fontSize: AppSizes.bodyLg,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}