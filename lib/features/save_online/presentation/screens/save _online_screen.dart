import 'package:easy_pay_app/core/constants/app_assets.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/routes/app_routes_name.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/bottomNav/presentation/widgets/search_card_widget.dart';
import 'package:flutter/material.dart';

class SaveOnlineScreen extends StatelessWidget {
  const SaveOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: "Save online",
      ),
      body: Padding(
        padding: EdgeInsets.all(context.scaleHeight(16)),
        child: Column(
          children: [
            SearchCardWidget(title: "Add", subtitle: "Add new save online account", imageAsset:AppAssets.addImage, onTap: (){Navigator.pushNamed(context, AppRoutesName.addScreen);}),
            SearchCardWidget(title: "Management", subtitle: "Manage your save online account", imageAsset:AppAssets.managementImage, onTap: (){Navigator.pushNamed(context, AppRoutesName.managementScreen);})
          ],
        ),
      ),
    );
  }
}
