import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/core/widgets/custom_app_bar.dart';
import 'package:nemea/core/widgets/custom_button.dart';
import 'package:nemea/core/widgets/custom_input_field.dart';
import 'package:nemea/features/people_list/presentation/bloc/user/user_bloc.dart';
import 'package:nemea/utils/extensions/context.dart';
import 'package:nemea/utils/locale_keys.g.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.people_list_login_title.tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.palette.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  CustomInputField(
                    controller: emailController,
                    labelText: LocaleKeys.people_list_login_email.tr(),
                  ),
                  SizedBox(height: 8),
                  CustomInputField(
                    controller: passwordController,
                    obscureText: true,
                    labelText: LocaleKeys.people_list_login_password.tr(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            CustomButton(
              width: 300,
              onPressed: () {
                sl<UserBloc>().add(
                  UserLoginEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
              },
              text: LocaleKeys.people_list_login_login.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
