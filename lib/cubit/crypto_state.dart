import 'package:flutter/foundation.dart';

abstract class CryptoState {}

class CryptoLoadingState extends CryptoState {}

class CryptoLoadedState extends CryptoState {
  List<dynamic> loadedCrypto;
  CryptoLoadedState({@required this.loadedCrypto}) : assert(loadedCrypto != null);
}

class CryptoErrorState extends CryptoState {}