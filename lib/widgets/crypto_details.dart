import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/crypto_cubit.dart';
import 'package:my_blog/cubit/crypto_state.dart';
import 'package:my_blog/services/crypto_api_provider.dart';

class CryptoDetails extends StatelessWidget {
  bool _fisrtStart = true;
  final id;

  CryptoDetails(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CryptoCubit cryptoCubit = context.watch<CryptoCubit>();
    if (_fisrtStart) {
      _fisrtStart = !_fisrtStart;
      cryptoCubit.fetchCryptoDetails(id, 'USD');
    }

    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state is CryptoLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        else if (state is CryptoLoadedState) {
          return RefreshIndicator(
            onRefresh: () async => cryptoCubit.fetchCryptoDetails(id, 'USD'),
            child: Container(),
          );
        }

        else {
          return LayoutBuilder(
              builder: (context, constraint) {
                return RefreshIndicator(
                  onRefresh: () async => cryptoCubit.fetchCryptoDetails(id, 'USD'),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraint.maxHeight),
                      child: Center(
                        child: Text(
                          'Error fetching crypto',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                );
              }
          );
        }
      },
    );
  }
}
