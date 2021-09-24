import 'package:roadrunner/Modals/AddCardRespo.dart';
import 'package:roadrunner/Modals/CheckStatusRespone.dart';
import 'package:roadrunner/Modals/RateYourTripRespo.dart';
import 'package:roadrunner/Modals/changepass_response.dart';
import 'package:roadrunner/Modals/forgetpass_response.dart';
import 'package:roadrunner/Modals/login_response.dart';
import 'package:roadrunner/Modals/providers_list_repo.dart';
import 'package:roadrunner/Modals/req_ride_respo.dart';
import 'package:roadrunner/Modals/services_response.dart';
import 'package:roadrunner/Modals/signup_response.dart';
import 'package:roadrunner/Modals/sub_services_response.dart';
import 'package:roadrunner/Modals/userprofile_response.dart';
import 'package:flutter/cupertino.dart';

import 'api_provider.dart';

class AddCardRepo{

  ApiProvider _apiProvider = ApiProvider();

  Future<AddCardRespo> addCardReq(String stripe_token,
      BuildContext context,String accessToken,String tokenType){
    return _apiProvider.addCard(stripe_token, context, accessToken, tokenType);
  }

}