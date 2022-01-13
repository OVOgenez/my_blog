import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/crypto_cubit.dart';
import 'package:my_blog/services/crypto_api_provider.dart';
import 'package:my_blog/widgets/crypto_list.dart';

class CryptoListPage extends StatelessWidget {
  final cryptoProvider = CryptoProvider();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoCubit>(
      create: (context) => CryptoCubit(cryptoProvider),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Crypto list'),
          centerTitle: true,
        ),
        body: CryptoList(),
      ),
    );
  }
}
