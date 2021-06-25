import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/core.dart';
import '../../providers/providers.dart';

class CountryDetailsScreen extends StatelessWidget {
  final NumberFormat numberFormat = NumberFormat('##,##,###');

  @override
  Widget build(BuildContext context) {
    final CountriesProvider _countriesProvider = Get.find();
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    Region region = _countriesProvider.selectedRegion;
    Country country = _countriesProvider.selectedCountry;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${region.regionName} / ${country.countryName}',
          style: textTheme.headline1,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //heading details
                _buildHeadingDetails(country, screenSize, textTheme),
                //build capital and area details
                _buildCapitalAndAreaDetails(country, screenSize, textTheme),
                //other details
                GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 3 / 1.3,
                  ),
                  children: [
                    //demonym
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(12.0),
                      decoration: WorldInfoTheme.countryDetailCardDecoration,
                      child: _buildDetailCard(
                        'Demonym',
                        country.demonym!,
                        textTheme,
                      ),
                    ),
                    //calling code
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(12.0),
                      decoration: WorldInfoTheme.countryDetailCardDecoration,
                      child: _buildDetailCard(
                        'Calling Code',
                        '+ ${country.callingCode}',
                        textTheme,
                      ),
                    ),
                    //currency
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(12.0),
                      decoration: WorldInfoTheme.countryDetailCardDecoration,
                      child: _buildDetailCard(
                        'Currency',
                        '${country.currencySymbol} ${country.currencyName}',
                        textTheme,
                      ),
                    ),
                    //population
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(12.0),
                      decoration: WorldInfoTheme.countryDetailCardDecoration,
                      child: _buildDetailCard(
                        'Population',
                        numberFormat.format(country.population),
                        textTheme,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingDetails(
    Country country,
    Size screenSize,
    TextTheme textTheme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //flag
        SvgPicture.network(
          country.countryFlag!,
          width: screenSize.width * 0.2,
        ),
        //name and code
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //name
            Text(
              country.countryName!,
              style: textTheme.headline4,
            ),
            //code
            Text(
              '(${country.countryCode!})',
              style: textTheme.headline5,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCapitalAndAreaDetails(
    Country country,
    Size screenSize,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //capital
          _buildDetailCard('Capital', country.capital!, textTheme),
          //area
          _buildDetailCard('Area',
              '${numberFormat.format(country.area)} km\u00b2', textTheme),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
    String title,
    String value,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //title
        Text(
          title,
          style: textTheme.headline5,
        ),
        //spacing
        SizedBox(height: 2.0),
        //value
        Text(
          value,
          style: textTheme.headline6,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
