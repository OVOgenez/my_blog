import 'package:flutter/material.dart';
import 'package:my_blog/pages/crypto_list_page.dart';
import 'package:my_blog/widgets/checkbox_field.dart';
import 'package:my_blog/widgets/input_field.dart';
import 'package:my_blog/pages/login_page.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Registration',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 28),
              InputField(labelText: 'Enter your Email'),
              SizedBox(height: 8),
              InputField(labelText: 'Enter your username'),
              SizedBox(height: 8),
              InputField(labelText: 'Enter password', passwordMod: true),
              SizedBox(height: 8),
              InputField(labelText: 'Confirm password', passwordMod: true),
              SizedBox(height: 12),
              CheckboxField(
                  title: 'I have read, understood the terms and conditions.'),
              SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  child: Text('Registration'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CryptoListPage()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: Text('Log in'),
        icon: Icon(Icons.person),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        ),
      ),
    );
  }
}
