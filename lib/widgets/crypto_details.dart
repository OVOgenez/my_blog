import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog/cubit/crypto_cubit.dart';
import 'package:my_blog/cubit/crypto_state.dart';
import 'package:my_blog/formats/formats.dart';

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

    var graphGradientColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
    ];

    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state is CryptoLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CryptoLoadedState) {
          var crypto = state.loadedCrypto.first;
          double price = crypto.quote['USD']['price'];
          double percent1h = crypto.quote['USD']['percent_change_1h'];
          double percent24h = crypto.quote['USD']['percent_change_24h'];
          double percent7d = crypto.quote['USD']['percent_change_7d'];
          double percent30d = crypto.quote['USD']['percent_change_30d'];
          double price1h = price - 100 * price / (100 + percent1h);
          double price24h = price - 100 * price / (100 + percent24h);
          double price7d = price - 100 * price / (100 + percent7d);
          double price30d = price - 100 * price / (100 + percent30d);
          DateTime dateTimeNow =
              DateTime.parse(crypto.quote['USD']['last_updated']);
          DateTime dateTimeFrom1h = dateTimeNow.subtract(Duration(hours: 1));
          DateTime dateTimeFrom24h = dateTimeNow.subtract(Duration(hours: 24));
          DateTime dateTimeFrom7d = dateTimeNow.subtract(Duration(days: 7));
          DateTime dateTimeFrom30d = dateTimeNow.subtract(Duration(days: 30));

          return LayoutBuilder(builder: (context, constraint) {
            return RefreshIndicator(
              onRefresh: () async => cryptoCubit.fetchCryptoDetails(id, 'USD'),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 6,
                              child: Text(
                                (price >= 10)
                                    ? Formats.price_formatD2.format(price)
                                    : Formats.price_formatD8.format(price),
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
                                            Formats.percent_format
                                                .format(percent24h / 100),
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
                                                ? Formats.price_formatD2
                                                    .format(price24h)
                                                : Formats.price_formatD8
                                                    .format(price24h),
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
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Text(Formats.datetime_from_format
                                .format(dateTimeFrom24h)),
                            Text(
                              ' TO ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Text(
                                Formats.datetime_to_format.format(dateTimeNow)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SizedBox(
                          height: 256,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                drawHorizontalLine: true,
                                getDrawingVerticalLine: (value) {
                                  if ([0, 1, 2, 3, 4].contains(value)) {
                                    return FlLine(
                                      color: Color(0xff37434d),
                                      strokeWidth: 1,
                                    );
                                  } else {
                                    return FlLine(strokeWidth: 0);
                                  }
                                },
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Color(0xff37434d),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(showTitles: false),
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  interval: 1,
                                  getTextStyles: (context, value) => TextStyle(
                                    color: Color(0xff68737d),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  getTitles: (value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return '30d';
                                      case 1:
                                        return '7d';
                                      case 2:
                                        return '24h';
                                      case 3:
                                        return '1h';
                                      case 4:
                                        return 'Now';
                                    }
                                    return '';
                                  },
                                  margin: 8,
                                ),
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTextStyles: (context, value) => TextStyle(
                                    color: Color(0xff67727d),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  margin: 8,
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: Color(0xff37434d), width: 1),
                              ),
                              // minX: 0 - 0.2,
                              // maxX: 4 + 0.2,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, price - price30d),
                                    FlSpot(1, price - price7d),
                                    FlSpot(2, price - price24h),
                                    FlSpot(3, price - price1h),
                                    FlSpot(4, price),
                                  ],
                                  colors: graphGradientColors,
                                  barWidth: 4,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    colors: graphGradientColors
                                        .map((color) => color.withOpacity(0.3))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Market Stats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(top: 12),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _marketStats(
                              context,
                              'Circulating Supply',
                              crypto.circulating_supply,
                            ),
                            SizedBox(height: 6),
                            _marketStats(
                              context,
                              'Total Supply',
                              crypto.total_supply,
                            ),
                            SizedBox(height: 6),
                            _marketStats(
                              context,
                              'Max Supply',
                              crypto.max_supply,
                            ),
                            SizedBox(height: 6),
                            _marketStats(
                              context,
                              'Volume 24H',
                              crypto.quote['USD']['volume_24h'],
                            ),
                            SizedBox(height: 6),
                            _marketStats(
                              context,
                              'Volume change 24H',
                              crypto.quote['USD']['volume_change_24h'],
                            ),
                            SizedBox(height: 6),
                            _marketStats(
                              context,
                              'Market Cap',
                              crypto.quote['USD']['market_cap'],
                            ),
                            SizedBox(height: 6),
                            _marketStats(
                              context,
                              'Market Cap Dominance',
                              crypto.quote['USD']['market_cap_dominance'],
                            ),
                            SizedBox(height: 6),
                            _marketStats(
                              context,
                              'Fully Diluted Market Cap',
                              crypto.quote['USD']['fully_diluted_market_cap'],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
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

  Widget _marketStats(context, lp, rp) {
    return Row(
      children: [
        Text('$lp  '),
        Expanded(
          child: Divider(
            height: 5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          (rp != null) ? '  ${Formats.compact_format.format(rp)}' : '  ?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
