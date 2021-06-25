import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../di/locator.dart';
import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WORLD INFO',
          style: textTheme.headline1,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GetBuilder<CountriesProvider>(builder: (
          CountriesProvider _countriesProvider,
        ) {
          switch (_countriesProvider.countiresState) {
            case CountriesState.LOADING:
              return _buildLoadingIndicator();
            case CountriesState.DEVICE_OFFLINE:
              return _buildErrorMessage(_countriesProvider.errorMessage);
            case CountriesState.ERROR:
              return _buildErrorMessage(_countriesProvider.errorMessage);
            case CountriesState.NO_COUNTRIES:
              return _buildErrorMessage(_countriesProvider.errorMessage);
            case CountriesState.LOADED:
              return _buildListOfCountries(
                _countriesProvider.regions,
                textTheme,
              );
            default:
              return _buildLoadingIndicator();
          }
        }),
      ),
    );
  }

  Widget _buildListOfCountries(List<Region> regions, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text(
            'Select a Region',
            style: textTheme.headline2,
          ),
          //list of regions
          ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: regions.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  //setting selected region and its countries
                  locator.get<CountriesProvider>().setSelectedRegion =
                      regions[index];
                  locator.get<CountriesProvider>().setSelectedCountryIndex = 0;
                  //navigate to next page
                  locator
                      .get<NavigationService>()
                      .navigateToNamed(COUNTRIES_ROUTE);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22.0),
                  margin: const EdgeInsets.only(top: 22.0),
                  decoration: BoxDecoration(
                    color: regions[index].regionColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    regions[index].regionName!,
                    style: textTheme.headline3!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
