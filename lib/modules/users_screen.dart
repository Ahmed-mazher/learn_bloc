import 'package:flutter/material.dart';

import '../shared/componenet/component.dart';

class UserModel {
  final int id;
  final String name;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
  });
}

// ignore: must_be_immutable
class UsersScreen extends StatelessWidget {
  List<UserModel> users= [
    UserModel(id: 1, name: 'Ahmed', phone: '+201007121902'),
    UserModel(id: 2, name: 'Ali', phone: '+201007121902'),
    UserModel(id: 3, name: 'Mohamed', phone: '+201007121902'),
    UserModel(id: 4, name: 'Sayed', phone: '+201007121902'),
    UserModel(id: 5, name: 'Raheem', phone: '+201057121902'),
    UserModel(id: 6, name: 'Mazher', phone: '+201007121902'),
  ];

  UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,

      ),
    );
  }

  
}
