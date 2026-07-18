import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class SearchCardWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final VoidCallback onTap;

  const SearchCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  State<SearchCardWidget> createState() => _SearchCardWidgetState();
}

class _SearchCardWidgetState extends State<SearchCardWidget> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.98;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          width: double.infinity,
          height: context.scaleHeight(115),
          margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(20),
            vertical: context.scaleHeight(14),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.scaleWidth(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppColors.gray200.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: context.scaleWidth(16),
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(6)),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: context.scaleWidth(12),
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                widget.imageAsset,
                width: context.scaleWidth(95),
                height: context.scaleHeight(80),
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
