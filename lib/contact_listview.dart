import 'package:contact_crud_hive/edit_form_diolog.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({
    super.key,
    required this.users,
    this.onEditContact,
  });

  final List<UserModel> users;
  final void Function(UserModel user)? onEditContact;

  Future<void> deleteUser(UserModel user) async {
    user.delete();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ExpansionTile(
              title: Text(
                '${users[index].user_id} - ${users[index].user_name}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email: ${users[index].email}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Telefone: ${users[index].telefone}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: () async  {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditFormDialog(users: users, userIndex: index);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromRGBO(43, 0, 255, 0.992),
                      ),
                      label: const Text(
                        'Editar',
                        style: TextStyle(color: Color.fromRGBO(43, 0, 255, 0.992)),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => deleteUser(users[index]),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: const Text(
                        "Excluir",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
