import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_blog/cubit/crypto_cubit.dart';
import 'package:my_blog/cubit/crypto_state.dart';

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

    var price_formatD2 = NumberFormat.currency(
      locale: 'ru',
      symbol: '\$',
    );
    var price_formatD8 = NumberFormat.currency(
      locale: 'ru',
      symbol: '\$',
      decimalDigits: 8,
    );
    var percent_format = NumberFormat.decimalPercentPattern(
      locale: 'ru',
      decimalDigits: 2,
    );

    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state is CryptoLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CryptoLoadedState) {
          var crypto = state.loadedCrypto.first;
          double price = crypto.quote['USD']['price'];
          double percent24h = crypto.quote['USD']['percent_change_24h'];
          double price24h = price - price * (100 - percent24h) / 100;

          return RefreshIndicator(
            onRefresh: () async => cryptoCubit.fetchCryptoDetails(id, 'USD'),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Text(
                            (price >= 10)
                                ? price_formatD2.format(price)
                                : price_formatD8.format(price),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('24H %'),
                                  Row(
                                    children: [
                                      Icon(
                                        (percent24h > 0)
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: (percent24h > 0)
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      Text(
                                        percent_format.format(percent24h / 100),
                                        style: TextStyle(
                                            color: (percent24h > 0)
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('24H \$'),
                                  Row(
                                    children: [
                                      Icon(
                                        (percent24h > 0)
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: (percent24h > 0)
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      Text(
                                        (price24h.abs() >= 10)
                                            ? price_formatD2.format(price24h)
                                            : price_formatD8.format(price24h),
                                        style: TextStyle(
                                            color: (percent24h > 0)
                                                ? Colors.green
                                                : Colors.red),
                                      ),
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
                ],
              ),
            ),
          );
        } else {
          return LayoutBuilder(builder: (context, constraint) {
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
          });
        }
      },
    );
  }
}
