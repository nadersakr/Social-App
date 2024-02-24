import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/auth/auth.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/widgets/animation_navigat_screen.dart';
import 'package:social_app/utils/widgets/custom_button.dart';
import 'package:social_app/views/screens/auth/signup/signup_screen.dart';
import 'package:social_app/views/screens/auth/widgets/custom_text_field.dart';
import 'package:social_app/views/screens/auth/widgets/text_row.dart';

class ResetPasswordFooter extends StatelessWidget {
  const ResetPasswordFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var authControoler = Provider.of<AuthController>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          controller: authControoler.mailLoginController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: authControoler.passwordLoginController,
          hintText: 'Password',
          obscureText: authControoler.isobscureText,
          suffixIcon: InkWell(
              onTap: authControoler.visibility,
              child: Icon(authControoler.isobscureText
                  ? Icons.visibility
                  : Icons.visibility_off)),
          keyboardType: TextInputType.text,
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'FORGOT PASSWORD',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.blue,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomButton(
          buttontext: "LogIN",
          onPressed: () {},
        ),
        const SizedBox(
          height: 30,
        ),
        TextRow( 
          text: 'Don\'t have account?,',
          textButton: "SignUp",
          onPressed: () {
            Navigator.of(context).push(
                AnimationNavigatScreen(const SignupScreen()));
          },
        )
      ],
    );
  }
}
