import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: notificationPressed,
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              print('Search');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const Column(
        children: [
          Image(
            image: NetworkImage('https://www.fnp.com/images/pr/x/v20201028190158/delicate-love-6-pink-roses-bunch_1.jpg'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  void notificationPressed() {
    print('pressed');
  }
}
