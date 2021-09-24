import 'package:roadrunner/Modals/AllServicesModel.dart';
import 'package:roadrunner/Modals/AllSubServicesModel.dart';

import 'AllProvidersList.dart';

class ProvidersListResponse {

  List<AllProvidersList> allServicesList = new List();
 String error;

  ProvidersListResponse.fromJson(List<dynamic> json) {

   allServicesList =  json.map((tagJson) => AllProvidersList.fromJson(tagJson)).toList();
  }

  ProvidersListResponse.withError(String errorValue)
      : error =errorValue;
}