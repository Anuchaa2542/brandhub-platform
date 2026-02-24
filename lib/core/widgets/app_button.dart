// core/widgets/app_button.dart

import 'package:brandhub/core/constants/app_color.dart';
import 'package:brandhub/core/constants/app_radius.dart';
import 'package:brandhub/core/constants/app_text_style.dart';
import 'package:brandhub/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

// core/widgets/app_button.dart
import 'package:brandhub/core/constants/app_sizes.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isOutlined ? Colors.transparent : (backgroundColor ?? AppColors.primary);
    final txtColor = isOutlined ? AppColors.primary : (textColor ?? Colors.white);
    final side = isOutlined ? const BorderSide(color: AppColors.primary) : BorderSide.none;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: txtColor,
          side: side,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.allMd),
          padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          textStyle: AppTextStyles.button.copyWith(color: txtColor),
        ),
        child: isLoading
            ? SizedBox(
                width: AppSizes.iconMd,
                height: AppSizes.iconMd,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: AppSizes.sm),
                  ],
                  Flexible(
                    child: AppText(
                      label,
                      style: AppTextStyles.button.copyWith(color: txtColor),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}