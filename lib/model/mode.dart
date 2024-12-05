class BitcoinPrice {
  final double rate;
  final String description;

  BitcoinPrice({
    required this.rate,
    required this.description,
  });

  factory BitcoinPrice.fromJson(Map<String, dynamic> json) {
    return BitcoinPrice(
      rate: json['bpi']['USD']['rate_float'],
      description: json['bpi']['USD']['description'],
    );
  }
}
