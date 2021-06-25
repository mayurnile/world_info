import 'package:get/get.dart';

import './locator.dart';
import '../providers/providers.dart';

void initProviders() {
  //notes Provider
  CountriesProvider countriesProvider = Get.put(CountriesProvider());
  locator.registerLazySingleton(() => countriesProvider);
}
