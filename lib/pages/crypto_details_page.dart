import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/crypto_cubit.dart';
import 'package:my_blog/services/crypto_api_provider.dart';
import 'package:my_blog/widgets/crypto_details.dart';

class CryptoDetailsPage extends StatelessWidget {
  final cryptoProvider = CryptoProvider();
  final id, name;

  CryptoDetailsPage(this.id, this.name, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoCubit>(
      create: (context) => CryptoCubit(cryptoProvider),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.network(
                  CryptoProvider.getCryptoIconPath(id),
                  height: 32,
                  width: 32,
                ),
              ),
              Text('$name'),
            ],
          ),
        ),
        body: CryptoDetails(id),
      ),
    );
  }
}
