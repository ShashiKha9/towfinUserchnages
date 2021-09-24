import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:roadrunner/HomePage/map_locationpicker.dart';
import 'package:roadrunner/Modals/CheckStatusRespone.dart';
import 'package:roadrunner/Modals/approximateprice_respo.dart';
import 'package:roadrunner/Modals/providers_list_repo.dart';
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/Utils/logging_interceptor.dart';
import 'package:roadrunner/bloc/LoginBloc.dart';
import 'package:roadrunner/navigation_home_screen.dart';
import 'package:roadrunner/walkthrough/T2Walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/body.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),


    );
  }


  @override
  void initState() {
    super.initState();

    initPrefs();

  }

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();





    new Future.delayed(const Duration(seconds: 3), () {

      if(prefs.getBool(SharedPrefsKeys.LOGEDIN)!=null){
        if(prefs.getBool(SharedPrefsKeys.LOGEDIN)){


          Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>
                  NavigationHomeScreen(),
            ),
          );

        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>
                  T2WalkThrough(),
            ),
          );
        }
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                T2WalkThrough(),
          ),
        );
      }



    });


  }




}
