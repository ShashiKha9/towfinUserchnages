
import 'dart:io';

import 'package:roadrunner/HomePage/home_screen.dart';
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
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/repository/login_repo.dart';
import 'package:roadrunner/repository/past_history_repo.dart';
import 'package:roadrunner/repository/userProfile_repo.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation_home_screen.dart';

class PastTripHistoryBloc {
  final PastHistoryRepo _pastHistoryRepo = PastHistoryRepo();
  final BehaviorSubject<PastTripListRespo> _subjectPastHistory =
      BehaviorSubject<PastTripListRespo>();

  pastHistoryReq(BuildContext context,String accessToken,String tokenType) async {
    PastTripListRespo response =
        await _pastHistoryRepo.fetchPastHistory(context, accessToken, tokenType);


    SharedPreferences prefs = await SharedPreferences.getInstance();


    _subjectPastHistory.sink.add(response);
  }


  dispose() {
    _subjectPastHistory.close();

    print("DISPOSED");
  }
  unSubscribeEvents(){

  }

  BehaviorSubject<PastTripListRespo> get subjectPastHistory => _subjectPastHistory;

}

Future<String> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

final bloc = PastTripHistoryBloc();
