import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../di/locator.dart';
import '../../providers/providers.dart';

class CountriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CountriesProvider _countriesProvider = Get.find();
    final TextTheme textTheme = Theme.of(context).textTheme;

    Region region = _countriesProvider.selectedRegion;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${region.regionName}',
          style: textTheme.headline1,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //search bar
                _buildSearchBar(textTheme),
                //title
                Text(
                  'Select a Country',
                  style: textTheme.headline2,
                ),
                //countries list
                _buildCountriesList(
                  region.regionColor!,
                  textTheme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      margin: const EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: WorldInfoTheme.FONT_LIGHT_COLOR,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        style: textTheme.headline3,
        decoration: InputDecoration(
          hintText: 'Type to Search',
          hintStyle: textTheme.headline2,
          border: InputBorder.none,
        ),
        onChanged: (String? value) {
          if (value != null)
            locator.get<CountriesProvider>().setSearchString = value.trim();
        },
      ),
    );
  }

  Widget _buildCountriesList(
    Color primaryColor,
    TextTheme textTheme,
  ) {
    return GetBuilder<CountriesProvider>(builder: (
      CountriesProvider _countriesProvider,
    ) {
      List<Country> countries = _countriesProvider.selectedRegion.countries;
      String _searchTerm = _countriesProvider.searchTerm;

      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: countries.length,
        itemBuilder: (BuildContext context, int index) {
          bool shouldBeDisplayed = true;

          if (_searchTerm.length != 0) {
            if (countries[index]
                .countryName!
                .toLowerCase()
                .contains(_searchTerm.toLowerCase()))
              shouldBeDisplayed = true;
            else
              shouldBeDisplayed = false;
          }

          int selectedIndex = _countriesProvider.selectedCountryIndex;
          Color cardColor =
              primaryColor.withOpacity(selectedIndex == index ? 0.9 : 0.5);

          return shouldBeDisplayed
              ? InkWell(
                  onTap: () {
                    //setting selected country and its index
                    _countriesProvider.setSelectedCountryIndex = index;

                    _countriesProvider.setSelectedCountry = countries[index];

                    //navigate to next page
                    locator
                        .get<NavigationService>()
                        .navigateToNamed(COUNTRY_DETAILS_ROUTE);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22.0),
                    margin: const EdgeInsets.only(top: 22.0),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      countries[index].countryName!,
                      style: textTheme.headline3!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink();
        },
      );
    });
  }
}
