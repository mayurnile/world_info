class Country {
  final String? countryName;
  final String? countryFlag;
  final String? capital;
  final String? countryCode;
  final String? demonym;
  final String? callingCode;
  final String? currencySymbol;
  final String? currencyName;
  final int? population;
  final double? area;

  Country(
      {required this.countryName,
      required this.countryFlag,
      required this.capital,
      required this.countryCode,
      required this.demonym,
      required this.callingCode,
      required this.currencySymbol,
      required this.currencyName,
      required this.population,
      required this.area});

  factory Country.fromJSON(Map<String, dynamic> data) {
    return Country(
      countryName: data['name'] ?? '',
      countryFlag: data['flag'] ?? '',
      capital: data['capital'] ?? '',
      countryCode: data['alpha3Code'] ?? '',
      demonym: data['demonym'] ?? '',
      callingCode: data['callingCodes'][0] ?? '',
      currencySymbol: data['currencies'][0]['symbol'] ?? '',
      currencyName: data['currencies'][0]['name'] ?? '',
      population: data['population'] ?? 0,
      area: data['area'] ?? 0,
    );
  }
}
