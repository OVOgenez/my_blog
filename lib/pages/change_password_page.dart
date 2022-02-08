import 'package:flutter/material.dart';
import 'package:my_blog/widgets/input_field.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.lock),
            ),
            Text('Change password'),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Changing password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 28),
              InputField(
                  labelText: 'Enter your old password', passwordMod: true),
              SizedBox(height: 8),
              InputField(labelText: 'Enter new password', passwordMod: true),
              SizedBox(height: 8),
              InputField(labelText: 'Repeat new password', passwordMod: true),
              SizedBox(height: 28),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: Text('Confirm'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
