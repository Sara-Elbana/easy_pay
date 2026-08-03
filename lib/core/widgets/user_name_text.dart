import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_pay_app/features/profile/presentation/cubit/profile_state.dart';

class UserNameText extends StatelessWidget {
  final TextStyle? style;
  final String fallbackText;

  const UserNameText({
    super.key,
    this.style,
    this.fallbackText = "User",
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String userName = fallbackText;
        if (state is BaseSuccess) {
          userName = (state as BaseSuccess).data.name;
        }
        return Text(
          userName,
          style: style,
        );
      },
    );
  }
}