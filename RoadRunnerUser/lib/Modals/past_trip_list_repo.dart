import 'package:roadrunner/Modals/AllPastTripList.dart';
import 'package:roadrunner/Modals/AllServicesModel.dart';
import 'package:roadrunner/Modals/AllSubServicesModel.dart';

import 'AllProvidersList.dart';

class PastTripListRespo {

  List<AllPastTripList> allPastTripList = new List();
 String error;

  PastTripListRespo.fromJson(List<dynamic> json) {

   allPastTripList =  json.map((tagJson) => AllPastTripList.fromJson(tagJson)).toList();
  }

  PastTripListRespo.withError(String errorValue)
      : error =errorValue;
}