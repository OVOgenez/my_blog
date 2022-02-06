import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
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
              child: Icon(Icons.settings),
            ),
            Text('Settings'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text('\$', style: TextStyle(fontSize: 22)),
                        ),
                        SizedBox(width: 8),
                        Text('Currency: USD', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      child: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mode_night),
                        SizedBox(width: 8),
                        Text('Mode: Night', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                      child: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock),
                          SizedBox(width: 8),
                          Text('Change password',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
