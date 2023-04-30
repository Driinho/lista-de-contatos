import 'package:flutter/material.dart';

import 'common/box_user.dart';
import 'form_contact_fielder.dart';
import 'model/user.dart';

// ignore: must_be_immutable
class FormContact extends StatefulWidget {
  const FormContact({Key? key}): super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormContactState createState() => _FormContactState();
}

class _FormContactState extends State<FormContact> {
  final _formKey = GlobalKey<FormState>();
  final idUserControl = TextEditingController();
  final nameUserControl = TextEditingController();
  final emailUserControl = TextEditingController();
  final telefoneUserControl = TextEditingController();

  Future<void> addUser(String id, String name, String email, String telefone) async {
    if (_formKey.currentState!.validate() == true) {
      _formKey.currentState!.save();

      final user = UserModel()
        ..user_id = id
        ..user_name = name
        ..email = email
        ..telefone = telefone;

      // pega a caixa aberta
      final box = UserBox.getUsers();
      box.add(user).then((value) => _clearTextControllers());
    }
  }

  @override
  void dispose() {
    idUserControl.dispose();
    nameUserControl.dispose();
    emailUserControl.dispose();
    telefoneUserControl.dispose();
    super.dispose();
  }

  void _clearTextControllers() {
    idUserControl.clear();
    nameUserControl.clear();
    emailUserControl.clear();
    telefoneUserControl.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              FormContactFielder(
                controller: idUserControl,
                iconData: Icons.person,
                hintTextName: 'Código',
              ),
              const SizedBox(height: 10),
              FormContactFielder(
                controller: nameUserControl,
                iconData: Icons.person_outline,
                hintTextName: 'Nome',
              ),
              const SizedBox(height: 10),
              FormContactFielder(
                controller: emailUserControl,
                iconData: Icons.email_outlined,
                textInputType: TextInputType.emailAddress,
                hintTextName: 'Email',
              ),
              const SizedBox(height: 10),
              FormContactFielder(
                controller: telefoneUserControl,
                iconData: Icons.phone_outlined,
                textInputType: TextInputType.phone,
                hintTextName: 'Telefone',
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => addUser(
                          idUserControl.text,
                          nameUserControl.text,
                          emailUserControl.text,
                          telefoneUserControl.text,
                        ),
                        child: const Text('Adicionar'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearTextControllers,
                        child: const Text('Limpar Campos'),
                      ),
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