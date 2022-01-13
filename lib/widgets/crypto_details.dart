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
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: state.loadedCrypto.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: ListTile(
                  tileColor: index % 2 == 0 ? Colors.white : Colors.grey[100],
                  leading: SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        Image.network(
                          CryptoProvider.getCryptoIconPath(state.loadedCrypto[index].id),
                          height: 40,
                          width: 40,
                        ),
                        Text(
                          'id ${state.loadedCrypto[index].id}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    '${state.loadedCrypto[index].name}',
                    style: TextStyle(fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${state.loadedCrypto[index].symbol}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text('${state.loadedCrypto[index].quote['USD']['price']}'),
                ),
              ),
            ),
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
