import 'package:contact_crud_hive/common/box_user.dart';
import 'package:contact_crud_hive/form_contact_fielder.dart';
import 'package:contact_crud_hive/model/user.dart';
import 'package:flutter/material.dart';

class EditFormDialog extends StatefulWidget {
  final List<UserModel> users;
  final int userIndex;

  const EditFormDialog({
    Key? key,
    required this.users,
    required this.userIndex,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditFormDialogState createState() => _EditFormDialogState();
}

class _EditFormDialogState extends State<EditFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.users[widget.userIndex].user_name;
    _emailController.text = widget.users[widget.userIndex].email;
    _telefoneController.text = widget.users[widget.userIndex].telefone;
  }

  Future<void> editUser(String id, String nome, String email, String telefone) async {
    if (_formKey.currentState!.validate() == true) {
      _formKey.currentState!.save();

      final user = UserModel()
        ..user_id = id
        ..user_name = nome
        ..email = email
        ..telefone = telefone;

      final box = UserBox.getUsers();
      box.putAt(widget.userIndex, user).then((value) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Contato'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey, 
          child: Column(
            children: [
              FormContactFielder(
                controller: _nomeController,
                iconData: Icons.person_outline,
                hintTextName: 'Nome',
              ),
              const SizedBox(height: 20,),
              FormContactFielder(
                controller: _emailController,
                iconData: Icons.email_outlined,
                hintTextName: 'Email',
              ),
              const SizedBox(height: 20,),
              FormContactFielder(
                controller: _telefoneController,
                iconData: Icons.phone,
                hintTextName: 'Telefone',
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  editUser(
                    widget.users[widget.userIndex].user_id,
                    _nomeController.text,
                    _emailController.text,
                    _telefoneController.text,
                  );
                },
                child: const Text('Salvar'),
              ),
            ],
          )
        )
      ),
    );
  }
}