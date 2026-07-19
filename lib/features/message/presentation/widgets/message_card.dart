import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageCard extends StatelessWidget {
  final IconData? icon;
  final String? iconAsset;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final String date;
  final VoidCallback? onTap;

  const MessageCard({
    super.key,
    this.icon,
    this.iconAsset,
    required this.iconBackgroundColor,
    required this.title,
    required this.subtitle,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.scaleHeight(64),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.scaleWidth(15)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 5),
              blurRadius: 30,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(12)),
          child: Row(
            children: [
              Container(
                width: context.scaleWidth(40),
                height: context.scaleHeight(40),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(context.scaleWidth(10)),
                ),
                child: Center(
                  child: iconAsset != null
                      ? SvgPicture.asset(
                          iconAsset!,
                          width: context.scaleWidth(20),
                          height: context.scaleHeight(20),
                        )
                      : Icon(
                          icon,
                          color: Colors.white,
                          size: context.scaleWidth(20),
                        ),
                ),
              ),
              SizedBox(width: context.scaleWidth(12)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: context.scaleWidth(16),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF343434),
                            height: 24 / 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          date,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: context.scaleWidth(12),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF989898),
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: context.scaleWidth(12),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF989898),
                        height: 16 / 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
