import 'package:roadrunner/Modals/AllPastTripList.dart';
import 'package:roadrunner/Modals/CheckStatusRespone.dart';
import 'package:roadrunner/Modals/RateYourTripRespo.dart';
import 'package:roadrunner/Modals/approximateprice_respo.dart';
import 'package:roadrunner/Modals/login_response.dart';
import 'package:roadrunner/Modals/past_trip_list_repo.dart';
import 'package:roadrunner/Modals/providers_list_repo.dart';
import 'package:roadrunner/Modals/req_ride_respo.dart';
import 'package:roadrunner/Modals/services_response.dart';
import 'package:roadrunner/Modals/signup_response.dart';
import 'package:roadrunner/Modals/sub_services_response.dart';
import 'package:roadrunner/Modals/userprofile_response.dart';
import 'package:flutter/cupertino.dart';

import 'api_provider.dart';

class PastHistoryRepo{

  ApiProvider _apiProvider = ApiProvider();

  Future<PastTripListRespo> fetchPastHistory(BuildContext context,String accessToken,String tokenType){
    return _apiProvider.pastTripHistoryReq(context, accessToken, tokenType);
  }

}