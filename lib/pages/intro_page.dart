import 'package:flutter/material.dart';
import 'package:uraz_store_app/components/my_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(32)),
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.all(15),
              child: const Icon(
                Icons.star,
                size: 60,
                color: Colors.amber,
              ),
            ),
          ),

          //Uygulama başlığı
          const Text(
            'Uraz Store',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          //Uygulama alt başlığı
          const Text(
            'Alışverişin Yeni Adresi...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          //Button
          MyButton(
            child: const Icon(
              Icons.arrow_forward,
              size: 32,
              color: Colors.amber,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/homePage');
            },
          ),
        ],
      ),
    );
  }
}
