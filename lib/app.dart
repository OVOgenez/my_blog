import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/settings_cubit.dart';
import 'package:my_blog/cubit/settings_state.dart';
import 'package:my_blog/pages/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.mode
              ? ThemeData(
                  colorScheme: ColorScheme.dark(
                    onPrimary: Colors.white,
                    onSecondary: Colors.white,
                  ),
                )
              : ThemeData(
                  colorScheme: ColorScheme.light(
                    onPrimary: Colors.white,
                    onSecondary: Colors.white,
                  ),
                ),
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        );
      },
    );
  }
}
