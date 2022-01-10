class Crypto {
  dynamic id;
  dynamic name;
  dynamic symbol;
  dynamic slug;
  dynamic cmc_rank;
  dynamic num_market_pairs;
  dynamic circulating_supply;
  dynamic total_supply;
  dynamic max_supply;
  dynamic last_updated;
  dynamic date_added;
  List<dynamic> tags;
  dynamic platform;
  Map<String, dynamic> quote;

  Crypto({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.cmc_rank,
    this.num_market_pairs,
    this.circulating_supply,
    this.total_supply,
    this.max_supply,
    this.last_updated,
    this.date_added,
    this.tags,
    this.platform,
    this.quote,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      slug: json['slug'],
      cmc_rank: json['cmc_rank'],
      num_market_pairs: json['num_market_pairs'],
      circulating_supply: json['circulating_supply'],
      total_supply: json['total_supply'],
      max_supply: json['max_supply'],
      last_updated: json['last_updated:'],
      date_added: json['date_added'],
      tags: json['tags'],
      platform: json['platform'],
      quote: json['quote'],
    );
  }
}
