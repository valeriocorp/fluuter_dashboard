import 'package:dashboard/models/usuario.dart';
import 'package:dashboard/providers/user_form_provider.dart';
import 'package:dashboard/providers/users_provider.dart';
import 'package:dashboard/router/pages.dart';
import 'package:dashboard/ui/cards/white_card.dart';
import 'package:dashboard/ui/inputs/custom_inputs.dart';
import 'package:dashboard/ui/labels/custom_label.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends StatefulWidget {
  final String uid;

  const UserView({Key? key, required this.uid}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;
  @override
  void initState() {
    super.initState();
    final usersProvider = Get.find<UsersProvider>();
    final userFormProvider = Get.find<UserFormProvider>();
    usersProvider.getUserByID(widget.uid).then((userDB) {
      if (userDB != null) {
        userFormProvider.formKey = GlobalKey<FormState>();
        userFormProvider.user.value = userDB;

        setState(() {
          this.user = userDB;
        });
      } else {
        Get.offNamed(Routes.USERSROUTE);
      }
    });
  }

  @override
  void dispose() {
    this.user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "User View",
            style: CustomLabel.h1,
          ),
          SizedBox(
            height: 10,
          ),
          if (user == null)
            WhiteCard(
              child: Container(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          if (user != null) _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {0: FixedColumnWidth(250)},
        children: [
          TableRow(children: [
            _AvatarContainer(),
            _UserViewForm(),
          ]),
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Get.find<UserFormProvider>();
    final user = userFormProvider.user;
    return WhiteCard(
      title: 'Informacion general',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              initialValue: user.value.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Nombre del usuario',
                label: 'Nombre',
                icon: Icons.supervised_user_circle_outlined,
              ),
              onChanged: (value) =>
                  userFormProvider.copyUserWith(nombre: value),
              validator: (valor) {
                if (valor == null || valor.isEmpty) return 'Ingrese un nombre';
                if (valor.length < 2)
                  return 'El nombre tiene que tener mas de dos caracteles';
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: user.value.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Correo del usuario',
                label: 'Correo',
                icon: Icons.mark_email_read_outlined,
              ),
              onChanged: (value) =>
                  userFormProvider.copyUserWith(correo: value),
              validator: (value) {
                if (!EmailValidator.validate(value ?? ''))
                  return 'Email no valido';
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 100,
              ),
              child: ElevatedButton(
                  onPressed: () async {
                    final saved = await userFormProvider.updateUser();
                    if (saved) {
                      Get.find<UsersProvider>().refreshUser(user.value);
                      Get.snackbar(
                          'Actualizacion correcta', 'Usuario actualizado',
                          backgroundColor: Colors.white.withOpacity(0.4));
                    } else {
                      Get.snackbar('Error', 'No se pudo guardar',
                          backgroundColor: Colors.red.withOpacity(0.4));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.indigo,
                    ),
                    shadowColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.save_outlined,
                        size: 20,
                      ),
                      Text(
                        " Guardar",
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Get.find<UserFormProvider>();
    final user = userFormProvider.user;
    final image = (user.value.img == null)
        ? Image(image: AssetImage('no-image.jpg'))
        : Obx(() => FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: user.value.img!));

    return WhiteCard(
      width: 250,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: CustomLabel.h2,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(
                    child: image,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        elevation: 0,
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowMultiple: false,
                            allowedExtensions: ['jpeg', 'jpg', 'png'],
                          );

                          if (result != null) {
                            PlatformFile file = result.files.first;
                            Get.defaultDialog(
                              content: Container(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                            final newUser = await userFormProvider.uploadImage(
                                '/uploads/usuarios/${user.value.uid}',
                                file.bytes!);
                            Get.find<UsersProvider>().refreshUser(newUser);
                            Get.back();
                          } else {
                            // User canceled the picker
                            print('No se selecciono nada');
                          }
                        },
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Text(user.value.nombre);
            }),
          ],
        ),
      ),
    );
  }
}
