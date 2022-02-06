import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/settings_cubit.dart';
import 'package:my_blog/cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsCubit settingsCubit = context.watch<SettingsCubit>();

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
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
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                state.currency ? '\€' : '\$',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              state.currency
                                  ? 'Currency: EUR'
                                  : 'Currency: USD',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                          child: Switch(
                            value: state.currency,
                            onChanged: (value) {
                              settingsCubit.changeSettings(
                                currency: value,
                                mode: state.mode,
                              );
                            },
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
                            Icon(
                                state.mode ? Icons.mode_night : Icons.wb_sunny),
                            SizedBox(width: 8),
                            Text(
                              state.mode ? 'Mode: Night' : 'Mode: Day',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                          child: Switch(
                            value: state.mode,
                            onChanged: (value) {
                              settingsCubit.changeSettings(
                                currency: state.currency,
                                mode: value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  InkWell(
                    onTap: () {},
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
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
      },
    );
  }
}
