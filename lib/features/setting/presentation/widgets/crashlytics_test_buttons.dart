import 'package:easy_pay_app/core/di/service_locator.dart';
import 'package:easy_pay_app/core/services/crashlytics_service.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsTestButtons extends StatelessWidget {
  const CrashlyticsTestButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
      padding: EdgeInsets.all(context.scaleWidth(12)),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(context.scaleWidth(16)),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bug_report_rounded,
                  size: 18, color: Color(0xFF3629B7)),
              SizedBox(width: context.scaleWidth(6)),
              Text(
                'Crashlytics Testing',
                style: TextStyle(
                  fontSize: context.scaleWidth(13),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3629B7),
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(10)),
          Row(
            children: [
              Expanded(
                child: _CrashButton(
                  label: 'Crashes',
                  color: const Color(0xFFE53935),
                  icon: Icons.error_outline_rounded,
                  onTap: () {
                    FirebaseCrashlytics.instance.crash();
                  },
                ),
              ),
              SizedBox(width: context.scaleWidth(8)),
              Expanded(
                child: _CrashButton(
                  label: 'Non-Fatal',
                  color: const Color(0xFFFB8C00),
                  icon: Icons.warning_amber_rounded,
                  onTap: () async {
                    await getIt<CrashlyticsService>().recordError(
                      Exception('Manual Non-Fatal Test Error'),
                      StackTrace.current,
                      reason: 'SETTINGS_NON_FATAL_TEST',
                      fatal: false,
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Non-Fatal error reported to Crashlytics!'),
                          backgroundColor: Color(0xFFFB8C00),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(width: context.scaleWidth(8)),
              Expanded(
                child: _CrashButton(
                  label: 'ANRs',
                  color: const Color(0xFF7B1FA2),
                  icon: Icons.hourglass_empty_rounded,
                  onTap: () async {
                    await getIt<CrashlyticsService>()
                        .log('Simulated ANR / App Hang Event');
                    await getIt<CrashlyticsService>().recordError(
                      Exception('Manual ANR / App Hang Test Error'),
                      StackTrace.current,
                      reason: 'SETTINGS_ANR_TEST',
                      fatal: false,
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('ANR event recorded in Crashlytics!'),
                          backgroundColor: Color(0xFF7B1FA2),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CrashButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _CrashButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: context.scaleHeight(10),
          horizontal: context.scaleWidth(4),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleWidth(10)),
        ),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.scaleWidth(18), color: Colors.white),
          SizedBox(height: context.scaleHeight(4)),
          Text(
            label,
            style: TextStyle(
              fontSize: context.scaleWidth(11),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
