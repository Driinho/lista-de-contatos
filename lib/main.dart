import 'package:contact_crud_hive/home_contact.dart';
import 'package:contact_crud_hive/model/user.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  /** Registra o Adapter */
  Hive.registerAdapter(UserModelAdapter());
  /** Abre um Box tipado */
  await Hive.openBox<UserModel>('users');

  final ThemeData theme = ThemeData();

  runApp( MaterialApp(
    home: const HomeContact(),
    theme: ThemeData().copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: Colors.blueGrey[800],
      )
    ),
    debugShowCheckedModeBanner: false,
  ));
}
