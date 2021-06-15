import 'package:dashboard/providers/auth_provider.dart';
import 'package:dashboard/providers/register_form_provider.dart';
import 'package:dashboard/router/pages.dart';
import 'package:dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:dashboard/ui/buttons/link_text.dart';
import 'package:dashboard/ui/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  final RegisterFormController registerFormController =
      Get.put(RegisterFormController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 370),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: registerFormController.formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => registerFormController.name = value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: CustomInputs.authInputDecoration(
                    hint: 'Ingrese su nombre',
                    label: 'Nombre',
                    icon: Icons.verified_user,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Ingrese su nombre';
                    if (value.length < 2)
                      return 'El nombre debe tener por lo menos 2 caracteres';
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (!EmailValidator.validate(value ?? ''))
                      return 'Email no valido';
                    return null;
                  },
                  onChanged: (value) => registerFormController.email = value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                  onChanged: (value) => registerFormController.password = value,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: CustomInputs.authInputDecoration(
                    hint: '********',
                    label: 'Password',
                    icon: Icons.lock_open_rounded,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Ingrese su contraseña';
                    if (value.length < 6)
                      return 'La contraseña debe tener por lo menos 6 caracteres';
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomOutlinedButton(
                  onPressed: () {
                    final validForm = registerFormController.validateForm();
                    if (!validForm) return;

                    final authProvider = Get.find<AuthProvider>();
                    authProvider.register(
                      registerFormController.email,
                      registerFormController.password,
                      registerFormController.name,
                    );
                  },
                  text: "Crer Cuenta",
                ),
                SizedBox(
                  height: 20,
                ),
                LinkText(
                  text: 'Ir al login',
                  onPressed: () {
                    Get.offNamed(Routes.LOGINROUTE);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
