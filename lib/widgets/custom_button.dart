import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.isLoading = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: backgroundColor == null ? AppColors.primaryGradient : null,
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        boxShadow: backgroundColor == null ? [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: foregroundColor ?? Colors.white,
          shadowColor: Colors.transparent,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : child,
      ),
    );
  }
}