import 'package:dashboard/providers/auth_provider.dart';
import 'package:dashboard/providers/login_form_provider.dart';
import 'package:dashboard/router/pages.dart';
import 'package:dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:dashboard/ui/buttons/link_text.dart';
import 'package:dashboard/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final authFormController = Get.find<AuthProvider>();
  final loginFormController =
      Get.put<LoginFormController>(LoginFormController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 370),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: loginFormController.formKey,
            child: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (_) => onFormSubmit(),
                  onChanged: (value) => loginFormController.email.value = value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: (value) {
                    if (!EmailValidator.validate(value ?? ''))
                      return 'Email no valido';
                    return null;
                  },
                  decoration: CustomInputs.authInputDecoration(
                    hint: 'Ingrese su correo',
                    label: 'Email',
                    icon: Icons.email_outlined,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onFieldSubmitted: (_) => onFormSubmit(),
                  onChanged: (value) =>
                      loginFormController.password.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Ingrese su contraseña';
                    if (value.length < 6)
                      return 'La contraseña debe tener por lo menos 6 caracteres';
                    return null;
                  },
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: CustomInputs.authInputDecoration(
                    hint: '********',
                    label: 'Password',
                    icon: Icons.lock_open_rounded,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomOutlinedButton(
                  onPressed: () => onFormSubmit(),
                  text: "Ingresar",
                ),
                SizedBox(
                  height: 20,
                ),
                LinkText(
                  text: 'Nueva cuenta',
                  onPressed: () {
                    Get.offNamed(Routes.REGISTERROUTE);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onFormSubmit() {
    final isValid = loginFormController.validateForm();
    if (isValid)
      authFormController.login(
          loginFormController.email.value, loginFormController.password.value);
  }
}
