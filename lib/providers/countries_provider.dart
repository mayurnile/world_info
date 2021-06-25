import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../core/core.dart';
import '../core/utils/utils.dart';

class CountriesProvider extends GetxController {
  //data variables
  late List<Region> _regionsList;
  late Region _selectedRegion;
  late Country _selectedCountry;
  late int _selectCountryIndex;
  late String _searchString;

  //controller variables
  late CountriesState _state;
  late String _errorMessage;

  @override
  void onInit() async {
    super.onInit();

    //initialize variables
    _regionsList = [];
    _selectCountryIndex = 0;
    _searchString = '';
    _state = CountriesState.LOADING;
    _errorMessage = '';
    //getting list of regions from api and sorting all data
    await fetchAllRegions();
  }

  //setters
  set setSelectedRegion(Region rg) => _selectedRegion = rg;
  set setSelectedCountry(Country ct) => _selectedCountry = ct;
  set setSelectedCountryIndex(int cti) {
    _selectCountryIndex = cti;
    update();
  }

  set setSearchString(String ss) {
    _searchString = ss;
    update();
  }

  //getters
  get regions => _regionsList;
  get selectedRegion => _selectedRegion;
  get selectedCountry => _selectedCountry;
  get selectedCountryIndex => _selectCountryIndex;
  get countiresState => _state;
  get searchTerm => _searchString;
  get errorMessage => _errorMessage;

  ///[Method for getting all data and sorting in the list]
  ///
  Future<void> fetchAllRegions() async {
    _state = CountriesState.LOADING;

    try {
      ///fetch data is device is online
      ///else throw error
      if (await NetworkInfo.isConnected) {
        var url = Uri.parse("https://restcountries.eu/rest/v2/all");
        var response = await http.get(url);

        List<dynamic> parsedJSON = json.decode(response.body) as List<dynamic>;

        //creating a temporary map of data
        Map<String, List<Country>?> regionalData = {};

        //traversing all data and sorting it into different regions
        parsedJSON.forEach((countryDetail) {
          Map<String, dynamic> countryData =
              countryDetail as Map<String, dynamic>;

          Country fetchedCountry = Country.fromJSON(countryData);
          String countryRegion = countryDetail['region'].length != 0
              ? countryDetail['region']
              : 'Asia';

          //checking if region is already present in map
          //if present then appending the new country to it
          //else adding the region entry with the country
          if (regionalData.containsKey(countryRegion)) {
            List<Country>? tempList = regionalData[countryRegion] ?? [];
            tempList.add(fetchedCountry);
          } else {
            regionalData.addAll(
              {
                countryRegion: [fetchedCountry],
              },
            );
          }
        });

        //generating complete list of regions from the mapped data
        int i = 0;
        regionalData.forEach((regionName, regionData) {
          Region fetchedRegion = Region.fromJSON(
            regionName,
            WorldInfoTheme.regionsColors[i],
            regionData ?? [],
          );

          _regionsList.add(fetchedRegion);
          i++;
        });

        //updating that work is done
        _state = CountriesState.LOADED;
        update();
      } else {
        //throwing error that device is offline
        _state = CountriesState.DEVICE_OFFLINE;
        _errorMessage = 'Device is Offline!';
        update();
      }
    } catch (e) {
      //throwing the caught error
      _state = CountriesState.ERROR;
      _errorMessage = e.toString();
      update();
    }
  }

  // Future<void> fetchAndStoreProductsList() async {
  //   _state = ProductsState.LOADING;

  //   DatabaseHelper _databaseHelper = DatabaseHelper();
  //   final Future<Database> dbFuture = _databaseHelper.initializeDatabase();

  //   //fetch latest products list if online
  //   if (await NetworkInfo.isConnected) {
  //     var url = Uri.parse('https://jsonkeeper.com/b/YIDG');
  //     var response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> parsedJSON = json.decode(response.body);
  //       List<dynamic> parsedProducts = parsedJSON['data']['products'];

  //       if (parsedProducts.length != 0) {
  //         //storing fetched list into database
  //         dbFuture.then((database) async {
  //           _databaseHelper.deleteAllProducts();

  //           parsedProducts.forEach((product) {
  //             Product newProduct = Product.fromMap(product);
  //             _databaseHelper.insertProduct(newProduct);
  //           });

  //           //fetch list from database
  //           _productsList = [];
  //           List<Product> _products = await _databaseHelper.getProductsList();
  //           _productsList = _products;
  //         });
  //       } else {
  //         _state = ProductsState.NO_PRODUCTS;
  //       }
  //     }
  //   }

  //   //fetch list from database if list is empty
  //   if (_productsList.length == 0) {
  //     List<Product> _products = await _databaseHelper.getProductsList();
  //     _productsList = _products;
  //     _state = ProductsState.LOADED;
  //   }

  //   update();
  // }

  // Future<void> addToCart({required Product product, int quantity = 1}) async {
  //   try {
  //     Product? existingProduct = _cartList.firstWhere(
  //       (cartItem) => cartItem.prodId == product.prodId,
  //     );

  //     if (existingProduct != null) {
  //       existingProduct.quantity = existingProduct.quantity! + quantity;
  //     }

  //     update();
  //   } catch (e) {
  //     Product newProduct = Product(
  //       prodId: product.prodId,
  //       prodImage: product.prodImage,
  //       prodName: product.prodName,
  //       prodPrice: product.prodPrice,
  //       prodSellPrice: product.prodPrice,
  //       quantity: quantity,
  //     );

  //     _cartList.insert(0, newProduct);
  //     update();
  //   }
  // }

  // Future<void> removeProduct(Product product) async {
  //   _cartList.removeWhere((cartItem) => cartItem.prodId == product.prodId);
  //   update();
  // }
}

enum CountriesState {
  LOADING,
  LOADED,
  NO_COUNTRIES,
  ERROR,
  DEVICE_OFFLINE,
}
