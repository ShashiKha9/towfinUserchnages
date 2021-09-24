
import 'dart:io';

import 'package:roadrunner/Modals/AddCardRespo.dart';
import 'package:roadrunner/Modals/changepass_response.dart';
import 'package:roadrunner/Modals/forgetpass_response.dart';
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/repository/addcard_repo.dart';
import 'package:roadrunner/repository/changepassword_repo.dart';
import 'package:roadrunner/repository/forgetpassword_repo.dart';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AddCardBloc {
  final AddCardRepo _addCardRepository = AddCardRepo();
  final BehaviorSubject<AddCardRespo> _subjectAddcard = BehaviorSubject<AddCardRespo>();

  addCardReq(String strip_token,
      BuildContext context,String accessToken,String tokenType) async {
    AddCardRespo response =
        await _addCardRepository.addCardReq(strip_token, context, accessToken, tokenType);

    showToast(response.message, context);

    _subjectAddcard.sink.add(response);
  }


  dispose() {
    _subjectAddcard.close();
  }

  unSubscribeEvents(){

    // {message: Password Updated}

  }

  BehaviorSubject<AddCardRespo> get subjectAddcard => _subjectAddcard;

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

final bloc = AddCardBloc();
