import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/crypto_cubit.dart';
import 'package:my_blog/services/crypto_api_provider.dart';
import 'package:my_blog/widgets/crypto_details.dart';

class CryptoDetailsPage extends StatelessWidget {
  final cryptoProvider = CryptoProvider();
  final id;

  CryptoDetailsPage(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoCubit>(
      create: (context) => CryptoCubit(cryptoProvider),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Crypto Details'),
          centerTitle: true,
        ),
        body: CryptoDetails(id),
      ),
    );
  }
}
