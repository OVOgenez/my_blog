import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/crypto_cubit.dart';
import 'package:my_blog/cubit/crypto_state.dart';
import 'package:my_blog/pages/crypto_details_page.dart';
import 'package:my_blog/services/crypto_api_provider.dart';
import 'package:my_blog/formats/formats.dart';

class CryptoList extends StatelessWidget {
  bool _fisrtStart = true;

  @override
  Widget build(BuildContext context) {
    final CryptoCubit cryptoCubit = context.watch<CryptoCubit>();
    if (_fisrtStart) {
      _fisrtStart = !_fisrtStart;
      cryptoCubit.fetchCryptoList(1, 100, 'USD');
    }

    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state is CryptoLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CryptoLoadedState) {
          return RefreshIndicator(
            onRefresh: () async => cryptoCubit.fetchCryptoList(1, 100, 'USD'),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: state.loadedCrypto.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                double price = state.loadedCrypto[index].quote['USD']['price'];
                double percent24h = state.loadedCrypto[index].quote['USD']
                    ['percent_change_24h'];

                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CryptoDetailsPage(
                              state.loadedCrypto[index].id,
                              state.loadedCrypto[index].name,
                            )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Image.network(
                            CryptoProvider.getCryptoIconPath(
                                state.loadedCrypto[index].id),
                            height: 48,
                            width: 48,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${state.loadedCrypto[index].name}',
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    (price >= 10)
                                        ? Formats.price_formatD2.format(price)
                                        : Formats.price_formatD8.format(price),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 4),
                                        margin: const EdgeInsets.only(right: 4),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        '${state.loadedCrypto[index].symbol}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        (percent24h > 0)
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: (percent24h > 0)
                                            ? Colors.green
                                            : Colors.red,
                                        size: 32,
                                      ),
                                      Text(Formats.percent_format
                                          .format(percent24h / 100)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return LayoutBuilder(builder: (context, constraint) {
            return RefreshIndicator(
              onRefresh: () async => cryptoCubit.fetchCryptoList(1, 100, 'USD'),
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
          });
        }
      },
    );
  }
}
