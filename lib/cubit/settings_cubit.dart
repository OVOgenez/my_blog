import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/settings_state.dart';
import 'package:my_blog/helpers/settings.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(currency: false, mode: true));

  Future<void> changeSettings({@required currency, @required mode}) async {
    Settings.currency = currency;
    Settings.mode = mode;
    emit(SettingsState(currency: currency, mode: mode));
  }
}