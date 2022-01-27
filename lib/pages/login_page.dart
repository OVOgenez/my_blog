import 'package:flutter/material.dart';
import 'package:my_blog/pages/crypto_list_page.dart';
import 'package:my_blog/widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: Text('Registration'),
        icon: const Icon(Icons.person_add),
        onPressed: () {},
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Log in',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 32),
              InputField(labelText: 'Enter your username'),
              SizedBox(height: 24),
              InputField(labelText: 'Enter your password', passwordMod: true),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Log in'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CryptoListPage()),
                    ),
                  ),
                  TextButton(
                    child: Text('I forgot my password'),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
