import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'common/box_user.dart';
import 'contact_listview.dart';
import 'form_contact.dart';
import 'model/user.dart';

class HomeContact extends StatefulWidget {
  const HomeContact({super.key});

  @override
  State<HomeContact> createState() => _HomeContactState();
}

class _HomeContactState extends State<HomeContact> {
  PageController pageController = PageController(initialPage: 0);
  int _paginaAtual = 0;

  final List<Widget> _telas = [
    const FormContact(),
    ValueListenableBuilder(
      valueListenable: UserBox.getUsers().listenable(),
      builder: (BuildContext context, Box userBox, Widget? child) {
        final users = userBox.values.toList().cast<UserModel>();
        if (users.isEmpty) {
          return const Center(
            child: Text(
              'No Users Found',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return ContactListView(
            users: users,
            // onEditContact: editUser,
          );
        }
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
      ),
      body: PageView(
        controller: pageController,
        children:_telas,
        onPageChanged: (index) {
          setState(() {
            _paginaAtual = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: (int index) {
          setState(() {
            _paginaAtual = index;
          });
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
        ],
      ),
    );
  }
}
