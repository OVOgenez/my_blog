import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/crypto_state.dart';
import 'package:my_blog/models/crypto.dart';
import 'package:my_blog/services/crypto_api_provider.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoProvider cryptoProvider;

  CryptoCubit(this.cryptoProvider) : assert(cryptoProvider != null), super(CryptoLoadingState());

  Future<void> fetchCrypts(start, limit, convert) async {
    try {
      emit(CryptoLoadingState());
      final List<Crypto> _loadedCryptoList = await cryptoProvider.getCrypts(start, limit, convert);
      emit(CryptoLoadedState(loadedCrypto: _loadedCryptoList));
    } catch (_) {
      emit(CryptoErrorState());
    }
  }
}