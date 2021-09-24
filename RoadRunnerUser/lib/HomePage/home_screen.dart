import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:roadrunner/HomePage/subscervice_screen.dart';
import 'package:roadrunner/Modals/AllServicesModel.dart';
import 'package:roadrunner/Modals/CheckStatusData.dart';
import 'package:roadrunner/Modals/CheckStatusRespone.dart';
import 'package:roadrunner/Modals/categorieslist.dart';
import 'package:roadrunner/Modals/optionDataModel.dart';
import 'package:roadrunner/Modals/services_response.dart';
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/Utils/logging_interceptor.dart';
import 'package:roadrunner/bloc/LoginBloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_theme.dart';


OptionsData optionsData;
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<CategoriesList> categoriesList = CategoriesList.categoriesList;
  List<CheckStatusData> checkStatusData = List();
  AnimationController animationController;
  bool multiple = true;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _tripRating = 1;
  Timer timer;

  SharedPreferences prefs;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

    initPreferences();

  }

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    bloc.fetchAllServicesReq(context,prefs.getString(SharedPrefsKeys.ACCESS_TOKEN),prefs.getString(SharedPrefsKeys.TOKEN_TYPE));


    timer =
        Timer.periodic(Duration(seconds: 2), (Timer t) =>     reqCheckAPI(context, prefs.getString(SharedPrefsKeys.ACCESS_TOKEN),prefs.getString(SharedPrefsKeys.TOKEN_TYPE)));



  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(brightness: Brightness.light, backgroundColor: AppTheme.chipBackground,elevation: 0,

      title: Text(
        'Road Runner',
        style: TextStyle(
          fontSize: 22,
          color: AppTheme.darkText,
          fontWeight: FontWeight.w700,
        ),
      ),

      ),

      // backgroundColor: AppTheme.chipBackground,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // appBar(),



              Container(
                width: double.infinity,
                height: size.height / 3.6,
                child:
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                        top: 10,
                        left: 15,
                        right: 15,
                        child: Stack(
                          children: [
                            Container(
                                height: size.height * 0.25,
                                width: size.width,
                                decoration: new BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.centerLeft,
                                        colors: [
                                          AppTheme.colorPrimary,
                                          AppTheme.colorPrimaryDark
                                        ]),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.lerp(Radius.circular(20),
                                            Radius.circular(20), 5),
                                        topRight: Radius.lerp(Radius.circular(20),
                                            Radius.circular(20), 5),
                                        bottomLeft: Radius.lerp(Radius.circular(20),
                                            Radius.circular(20), 5),
                                        bottomRight: Radius.lerp(Radius.circular(20),
                                            Radius.circular(20), 5)),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ),]

                                ),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    /*                                     Image.asset(
                                        "assets/images/dotsbg.png",
                                        width: 150,
                                        height: 150,
                                      ),
*/
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Center(
                                            child:
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child: Image.asset("assets/images/home.jpeg", fit: BoxFit.fill, height: size.height * 0.25,
                                                  width: size.width*0.99,)
                                            )



                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        )),
                  ],
                ),
              ),



              SizedBox(
                height: 0,
              ),
              Expanded(
                  child:getListofAllServices()


              ),
            ],
          ),



          // -----------------------------------xxxxxxxxxxxxxxxxxxxxxxxxxxx------------------------
      checkStatusData.length>0?
          BackdropFilter(

            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child:

            Container(
              alignment: Alignment.bottomCenter,
              child:  statusWiseWidget(
                    checkStatusData[0].status,
                    checkStatusData[0])

            ),

          ):Wrap(),




        ],

      ),

    );
  }


  Widget statusWiseWidget(String status, CheckStatusData checkStatusData) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    if (status == "SEARCHING") {
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(

                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),

                  SizedBox(height: 15,),
                  Text('We are looking for a service provider\nAccept your request',
                    style: TextStyle(
                        fontSize: 18, fontFamily: AppTheme.fontName),
                    textAlign: TextAlign.center,),

                ],
              ),

              Container(
                  alignment: Alignment.bottomCenter,
                  child:
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(

                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: Text(
                          "Cancel Request", style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,),
                      ),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              AppTheme.nearlyBlack),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(
                                      color: AppTheme.nearlyBlack)))),
                      onPressed: () async =>
                      {
                        prefs =
                        await SharedPreferences
                            .getInstance(),
                        showCupertinoDialog(
                          context: _scaffoldKey.currentContext,
                          builder: (context) =>
                              CupertinoAlertDialog(
                                content: Text(
                                    "Are you sure you want to cancel booking"),
                                actions: <Widget>[

                                  CupertinoDialogAction(
                                      child: Text("Yes"),
                                      onPressed: () =>
                                      {
                                        Navigator.of(context).pop(
                                            false),
                                        bloc.cancelTrip(_scaffoldKey.currentContext,
                                            prefs.getString(
                                                SharedPrefsKeys
                                                    .ACCESS_TOKEN),
                                            prefs.getString(
                                                SharedPrefsKeys
                                                    .TOKEN_TYPE),
                                            checkStatusData.id
                                                .toString(),
                                            _tripRating.toString())
                                      }
                                  ),
                                  CupertinoDialogAction(
                                    child: Text("No"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                  ),
                                ],
                              ),
                        ),


                      },
                    ),

                  )

              )

            ],
          )

      );
    } else
    if (status == "STARTED" || status == "ARRIVED" || status == "PICKEDUP") {
      return Positioned(
        /*Show Service Description*/
        bottom: 0,
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 0.0),
          width: width,
          height: height * 0.65,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: width,
                      height: height * 0.46,
                      padding: const EdgeInsets.all(
                          20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius
                              .only(
                              topRight: Radius.circular(
                                  25.0),
                              topLeft: Radius.circular(
                                  25.0)),
                          color: AppTheme
                              .colorPrimaryDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        crossAxisAlignment: CrossAxisAlignment
                            .end,
                        children: [
                          ElevatedButton(
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 10,
                                  right: 10,
                                  top: 15,
                                  bottom: 15),
                              child: Text("Call Captain",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors
                                          .black,
                                      fontFamily: AppTheme
                                          .fontName)),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty
                                    .all<Color>(
                                    Colors.white),
                                backgroundColor:
                                MaterialStateProperty
                                    .all<Color>(
                                    AppTheme.white),
                                shape: MaterialStateProperty
                                    .all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(
                                            25),
                                        side: BorderSide(
                                            color: AppTheme
                                                .white)))),
                            onPressed: () async =>
                            {
                              prefs =
                              await SharedPreferences
                                  .getInstance(),


                            },
                          ),
                          SizedBox(width: 5,),

                          Visibility(
                            visible: cancelBookingBtnVisibility(
                                checkStatusData),
                            child: ElevatedButton(
                              child: Padding(
                                padding:
                                EdgeInsets.only(left: 10,
                                    right: 10,
                                    top: 15,
                                    bottom: 15),
                                child: Text("Cancel Booking",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors
                                            .black,
                                        fontFamily: AppTheme
                                            .fontName)),
                              ),
                              style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty
                                      .all<Color>(
                                      Colors.white),
                                  backgroundColor:
                                  MaterialStateProperty
                                      .all<Color>(
                                      AppTheme.white),
                                  shape: MaterialStateProperty
                                      .all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius
                                              .circular(
                                              25),
                                          side: BorderSide(
                                              color: AppTheme
                                                  .white)))),
                              onPressed: () async =>
                              {


                                prefs =
                                await SharedPreferences
                                    .getInstance(),
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) =>
                                      CupertinoAlertDialog(
                                        content: Text(
                                            "Are you sure you want to cancel booking"),
                                        actions: <Widget>[

                                          CupertinoDialogAction(
                                              child: Text("Yes"),
                                              onPressed: () =>
                                              {
                                                Navigator.of(context).pop(
                                                    false),
                                                bloc.cancelTrip(_scaffoldKey.currentContext,
                                                    prefs.getString(
                                                        SharedPrefsKeys
                                                            .ACCESS_TOKEN),
                                                    prefs.getString(
                                                        SharedPrefsKeys
                                                            .TOKEN_TYPE),
                                                    checkStatusData.id
                                                        .toString(),
                                                    _tripRating.toString())
                                              }
                                          ),
                                          CupertinoDialogAction(
                                            child: Text("No"),
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                          ),
                                        ],
                                      ),
                                ),

                              },
                            ),
                          )
                        ],
                      ))),
              Positioned(
                child:
                Container(
                    height: height * 0.60,
                    width: width,
                    child:
                    Padding(
                      padding:

                      EdgeInsets.all(15),
                      child:
                      Column(
                        mainAxisSize: MainAxisSize
                            .max,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          checkStatusData.provider.avatar != null ?
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                //                   <--- border color
                                width: 2.0,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),

                            child:
                            ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60.0),),
                                child: new FadeInImage.assetNetwork(
                                  placeholder:
                                  'assets/images/userImage.png',
                                  image: checkStatusData.provider.avatar != null
                                      ? checkStatusData.provider.avatar
                                      : checkStatusData.provider.avatar,
                                  width: width * 0.25,
                                  height: height *
                                      0.12,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ) :
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                //                   <--- border color
                                width: 2.0,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),

                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(60.0),),
                              child: Image.asset(
                                'assets/images/userImage.png', height: 50,
                                width: 50,

                              ),
                            ),
                          ),
                          Padding(
                              padding:
                              EdgeInsets
                                  .only(
                                  left: 15, top: 15),
                              child:
                              Text(
                                checkStatusData.provider.firstName + " " +
                                    checkStatusData.provider.lastName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w400,
                                  fontFamily:
                                  AppTheme.fontName,
                                  color: AppTheme.white,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets
                                  .only(
                                  left: 15),
                              child:
                              Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Text(
                                    'Rating ' + checkStatusData.provider.rating,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.w300,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  ),

                                  SizedBox(width: 5,),
                                  RatingBarIndicator(
                                    rating: 1,
                                    itemBuilder: (context,
                                        index) =>
                                        Icon(
                                          Icons.star,
                                          color: Colors
                                              .amber,
                                        ),
                                    itemCount: 1,
                                    itemSize: 20.0,
                                    direction: Axis
                                        .horizontal,
                                  ),


                                ],
                              )
                          ),


                          Card(
                              margin: EdgeInsets.only(
                                  left: 30, right: 30, bottom: 20, top: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30))),
                              color: AppTheme.white,
                              elevation: 3,
                              child:
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(padding: EdgeInsets.only(
                                      left: 25, right: 5, top: 10, bottom: 10),
                                    child: Text(checkStatusData.provider_service
                                        .service_number.toString()),
                                  ),

                                  Container(
                                    height: 20,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(padding: EdgeInsets.only(
                                      left: 5, right: 25, top: 10, bottom: 10),
                                    child: Text(checkStatusData.provider_service
                                        .service_model.toString()),
                                  ),


                                ],
                              )),

                          showStatusWiseMessage(checkStatusData)

                        ],


                      ),
                    )
                ),
                bottom: height * 0.02,
              )
            ],
          ),
        ),
      );
    } else if (status == "DROPPED") {
      return Positioned(
        /*Show Service Description*/
        bottom: 0,
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 0.0),
          width: width,
          height: height * 0.75,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: width,
                      height: height * 0.70,
                      padding: const EdgeInsets.all(
                          20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius
                              .only(
                              topRight: Radius.circular(
                                  25.0),
                              topLeft: Radius.circular(
                                  25.0)),
                          color: AppTheme
                              .colorPrimaryDark),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        crossAxisAlignment: CrossAxisAlignment
                            .end,
                        children: [
                        ],
                      ))),
              Positioned(
                child:
                Container(
                    height: height * 0.65,
                    width: width,
                    child:
                    Padding(
                      padding:

                      EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .max,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          Padding(
                              padding:
                              EdgeInsets
                                  .only(
                                  left: 15, top: 15, bottom: 15),
                              child:
                              Text('Hey all issues resolved now!',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w400,
                                  fontFamily:
                                  AppTheme.fontName,
                                  color: AppTheme.white,
                                ),
                              )),
                          Padding(
                              padding:
                              EdgeInsets
                                  .only(
                                  left: 15, top: 15, bottom: 15),
                              child:
                              Text('Booking Id: ${checkStatusData.booking_id}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w400,
                                  fontFamily:
                                  AppTheme.fontName,
                                  color: AppTheme.white,
                                ),
                              )),
                          Padding(
                              padding:
                              EdgeInsets
                                  .only(
                                  left: 15, top: 15, bottom: 15),
                              child:
                              Text('Please find your Invoice below',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w400,
                                  fontFamily:
                                  AppTheme.fontName,
                                  color: AppTheme.white,
                                ),
                              )),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      left: 15, top: 5, bottom: 15),
                                  child:
                                  Text('Base Charges',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      right: 15, top: 5, bottom: 15),
                                  child:
                                  Text('\$${checkStatusData.payment.fixed}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),


                            ],

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      left: 15, top: 5, bottom: 15),
                                  child:
                                  Text('Distance Charges',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      right: 15, top: 5, bottom: 15),
                                  child:
                                  Text('\$${checkStatusData.payment.distance}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),


                            ],

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      left: 15, top: 5, bottom: 15),
                                  child:
                                  Text('Extra Service Charege',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      right: 15, top: 5, bottom: 15),
                                  child:
                                  Text('\$${checkStatusData.payment.tax}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),


                            ],

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      left: 15, top: 5, bottom: 15),
                                  child:
                                  Text('Total',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      right: 15, top: 5, bottom: 15),
                                  child:
                                  Text('\$${checkStatusData.payment.total}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),


                            ],

                          ),

                          Divider(color: Colors.white24,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      left: 15, top: 5, bottom: 15),
                                  child:
                                  Text('Amount to be paid',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                  EdgeInsets
                                      .only(
                                      right: 15, top: 5, bottom: 15),
                                  child:
                                  Text('\$${checkStatusData.payment.payable}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.w800,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  )),


                            ],

                          ),

                          showStatusWiseMessage(checkStatusData)

                        ],


                      ),
                    )
                ),
                bottom: height * 0.02,
              )
            ],
          ),
        ),
      );
    } else if (status == "COMPLETED") {
      return Positioned(
        /*Show Service Description*/
        bottom: 0,
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 0.0),
          width: width,
          height: height * 0.65,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: width,
                      height: height * 0.56,
                      padding: const EdgeInsets.all(
                          20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius
                              .only(
                              topRight: Radius.circular(
                                  25.0),
                              topLeft: Radius.circular(
                                  25.0)),
                          color: AppTheme
                              .colorPrimaryDark),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        crossAxisAlignment: CrossAxisAlignment
                            .end,
                        children: [
                          ElevatedButton(
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 30,
                                  right: 30,
                                  top: 15,
                                  bottom: 15),
                              child: Text("Submit",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors
                                          .black,
                                      fontFamily: AppTheme
                                          .fontName)),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty
                                    .all<Color>(
                                    Colors.white),
                                backgroundColor:
                                MaterialStateProperty
                                    .all<Color>(
                                    AppTheme.white),
                                shape: MaterialStateProperty
                                    .all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(
                                            25),
                                        side: BorderSide(
                                            color: AppTheme
                                                .white)))),
                            onPressed: () async =>
                            {
                              prefs =
                              await SharedPreferences
                                  .getInstance(),

                              bloc.rateYourTrip(context, prefs.getString(
                                  SharedPrefsKeys
                                      .ACCESS_TOKEN),
                                  prefs.getString(
                                      SharedPrefsKeys
                                          .TOKEN_TYPE),
                                  checkStatusData.id.toString(),
                                  _tripRating.toString())
                            },
                          ),

                          /*SizedBox(width: 5,),

                          ElevatedButton(
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 10,
                                  right: 10,
                                  top: 15,
                                  bottom: 15),
                              child: Text("SMS",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors
                                          .black,
                                      fontFamily: AppTheme
                                          .fontName)),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty
                                    .all<Color>(
                                    Colors.white),
                                backgroundColor:
                                MaterialStateProperty
                                    .all<Color>(
                                    AppTheme.white),
                                shape: MaterialStateProperty
                                    .all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(
                                            25),
                                        side: BorderSide(
                                            color: AppTheme
                                                .white)))),
                            onPressed: () async =>
                            {
                              prefs =
                              await SharedPreferences
                                  .getInstance(),


                            },
                          )*/
                        ],
                      ))),
              Positioned(
                child: Container(
                    height: height * 0.65,
                    width: width,
                    child:
                    Padding(
                      padding:

                      EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .max,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          Padding(
                              padding:
                              EdgeInsets
                                  .only(
                                  left: 15, top: 15, bottom: 15),
                              child:
                              Text(
                                'Please rate your Service provider',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w400,
                                  fontFamily:
                                  AppTheme.fontName,
                                  color: AppTheme.white,
                                ),
                              )),

                          checkStatusData.provider.avatar != null ?
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                //                   <--- border color
                                width: 2.0,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),

                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(60.0),),
                                child: new FadeInImage.assetNetwork(
                                  placeholder:
                                  'assets/images/userImage.png',
                                  image: checkStatusData.provider.avatar != null
                                      ? checkStatusData.provider.avatar
                                      : checkStatusData.provider.avatar,
                                  width: width * 0.25,
                                  height: height *
                                      0.12,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ) :
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                //                   <--- border color
                                width: 2.0,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),

                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(60.0),),
                              child: Image.asset(
                                'assets/images/userImage.png', height: 50,
                                width: 50,

                              ),
                            ),
                          ),
                          Padding(
                              padding:
                              EdgeInsets
                                  .only(
                                  left: 15, top: 15),
                              child:
                              Text(
                                checkStatusData.provider.firstName + " " +
                                    checkStatusData.provider.lastName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w400,
                                  fontFamily:
                                  AppTheme.fontName,
                                  color: AppTheme.white,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets
                                  .only(
                                  left: 15),
                              child:
                              Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Text(
                                    'Rating ' + checkStatusData.provider.rating,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.w300,
                                      fontFamily:
                                      AppTheme.fontName,
                                      color: AppTheme.white,
                                    ),
                                  ),

                                  SizedBox(width: 5,),
                                  RatingBarIndicator(
                                    rating: 1,
                                    itemBuilder: (context,
                                        index) =>
                                        Icon(
                                          Icons.star,
                                          color: Colors
                                              .amber,
                                        ),
                                    itemCount: 1,
                                    itemSize: 20.0,
                                    direction: Axis
                                        .horizontal,
                                  ),


                                ],
                              )
                          ),

                          Card(
                              margin: EdgeInsets.only(
                                  left: 30, right: 30, bottom: 20, top: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30))),
                              color: AppTheme.white,
                              elevation: 3,
                              child:
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(padding: EdgeInsets.only(
                                      left: 25, right: 5, top: 10, bottom: 10),
                                    child: Text(checkStatusData.provider_service
                                        .service_number.toString()),
                                  ),

                                  Container(
                                    height: 20,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(padding: EdgeInsets.only(
                                      left: 5, right: 25, top: 10, bottom: 10),
                                    child: Text(checkStatusData.provider_service
                                        .service_model.toString()),
                                  ),


                                ],
                              )),

                          RatingBar(
                            initialRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemSize: 30.0,
                            itemCount: 5,
                            minRating: 1,

                            ratingWidget: RatingWidget(
                              full: Image.asset('assets/images/star-filled.png',
                                color: Colors.amber,),
                              empty: Image.asset('assets/images/start.png',
                                  color: Colors.amber),
                            ),
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            onRatingUpdate: (rating) {
                              if (mounted) {
                                setState(() {
                                  _tripRating = rating.toInt();
                                });
                              }
                              print(rating);
                            },
                          ),
                          showStatusWiseMessage(checkStatusData)

                        ],


                      ),
                    )
                ),
                bottom: height * 0.02,
              )
            ],
          ),
        ),
      );
    } else {
      return Wrap();
    }
  }


  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'CBD',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
/*
              child: Material(
                color: Colors.transparent,
                child:
                InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child:
                  Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
*/
            ),
          ),
        ],
      ),
    );
  }

  Widget getListofAllServices(){
    return
      StreamBuilder<ServiceResponse>(
        stream: bloc.subjectAllServices.stream,
        builder: (context, snap) {
          return snap.data!=null?
            snap.data.allServicesList.length>0?
            FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child:
                          FutureBuilder<bool>(
                            future: getData(),
                            builder:
                                (BuildContext context, AsyncSnapshot<bool> snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              } else {
                                return GridView(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 12, right: 12),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  children: List<Widget>.generate(
                                    snap.data.allServicesList.length,
                                        (int index) {
                                      final int count = snap.data.allServicesList.length;
                                      final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                          parent: animationController,
                                          curve: Interval((1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn),
                                        ),
                                      );
                                      animationController.forward();
                                      return
                                        HomeListView(
                                        animation: animation,
                                        animationController: animationController,
                                        categoriesListData: snap.data.allServicesList[index],
                                        callBack: () {
                                          optionsData = OptionsData();

                                          optionsData.serviceTypeId = snap.data.allServicesList[index].id.toString();

                                          Navigator.push<dynamic>(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                              builder: (BuildContext context) =>
                                                  SubServicePage(
                                                    serviceName: snap.data.allServicesList[index].name,
                                                    serviceImg: snap.data.allServicesList[index].image,
                                                    serviceId: snap.data.allServicesList[index].id.toString(),

                                                  ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: multiple ? 2 : 1,
                                    mainAxisSpacing: 5.0,
                                    crossAxisSpacing: 5.0,
                                    childAspectRatio: 1.5,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ):
            NoDataFound():Visibility(child: Text('CONTAINER'),visible: false,);

        });
  }

  Future<CheckStatusResponse> reqCheckAPI(BuildContext context, String accessToken,String tokenType) async {
    /* ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));*/

    // progressDialog.show();

    try {
      Dio _dio;

      BaseOptions options =
      BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
      // var customHeaders = {
      //   'X-Requested-With': 'XMLHttpRequest',
      //   'Authorization': tokenType+" "+accesstoken
      //   // other headers
      // };

      // if(accesstoken!="")
      // options.headers.addAll(customHeaders);

      _dio = Dio(options);
      _dio.interceptors.add(LoggingInterceptor());


      String deviceTypeStr = Platform.isAndroid?"android":"ios";

      print(tokenType.toString()+" ACCESS "+accessToken.toString());
      _dio.options.headers = {"X-Requested-With":"XMLHttpRequest","Authorization" : tokenType.toString()+" "+accessToken.toString()};

      final String _reqCheck = "api/user/request/check";



      Response response = await _dio.get(baseUrl + _reqCheck.toString());

      print(response.toString()+"RESPONSS");
      // progressDialog.dismiss();

      final parsed = json.decode(response.toString());




      if (response != null) {
        // List<dynamic> body = jsonDecode(response.data);
        // progressDialog.dismiss();

        final parsed = json.decode(response.toString());

        var checkstatusModel = CheckStatusResponse.fromJson(parsed);

        setState(() {
          checkStatusData.clear();

          checkStatusData.addAll(checkstatusModel.data);


        });

        // print(checkstatusModel.data.toString()+"DATALIST");

      }



      return CheckStatusResponse.fromJson(response.data);

    } catch (error, stacktrace) {



      // showToast("Services Not Found", context);

      print("Exception occured: $error stackTrace: $stacktrace");
      return CheckStatusResponse.withError(_handleError(error));
    }
  }
  bool cancelBookingBtnVisibility(CheckStatusData checkStatusData) {
    if (checkStatusData.status == "STARTED") {
      return true;
    }
    else if (checkStatusData.status == "ARRIVED") {
      return true;
    } else if (checkStatusData.status == "PICKEDUP") {
      return false;
    } else if (checkStatusData.status == "DROPPED") {
      return false;
    } else {
      return false;
    }
  }

  Widget showStatusWiseMessage(CheckStatusData checkStatusData) {
    if (checkStatusData.status == "STARTED") {
      return Padding(
        padding: EdgeInsets.only(left: 55, right: 55, top: 10, bottom: 10),
        child: Text('Your service provider ${checkStatusData.provider
            .firstName} is on the way to serve you, We are requesting you to please hold a moment our support team contact you as soon as possible.', style: TextStyle(
            fontFamily: AppTheme.fontName, color: AppTheme.white, fontSize: 15),
          textAlign: TextAlign.center,),
      );
    }
    else if (checkStatusData.status == "ARRIVED") {
      return Padding(
        padding: EdgeInsets.only(left: 55, right: 55, top: 10, bottom: 10),
        child: Text('Your service provider ${checkStatusData.provider
            .firstName} arrives at your location and tries to identify your vehicle.', style: TextStyle(
            fontFamily: AppTheme.fontName, color: AppTheme.white, fontSize: 15),
          textAlign: TextAlign.center,),
      );
    } else if (checkStatusData.status == "PICKEDUP") {
      return Padding(
        padding: EdgeInsets.only(left: 55, right: 55, top: 10, bottom: 10),
        child: Text('Your service provider ${checkStatusData.provider
            .firstName}. Hope you found your service provider now he will soon fix your problem', style: TextStyle(
            fontFamily: AppTheme.fontName, color: AppTheme.white, fontSize: 15),
          textAlign: TextAlign.center,),
      );
    } else if (checkStatusData.status == "DROPPED") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding:
              EdgeInsets
                  .only(
                  left: 15, top: 5, bottom: 15),
              child:
              Text('Payment Mode ${checkStatusData.payment_mode}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  FontWeight.w400,
                  fontFamily:
                  AppTheme.fontName,
                  color: AppTheme.white,
                ),
              )),
          Padding(
              padding:
              EdgeInsets
                  .only(
                  right: 15, top: 5, bottom: 15),
              child:
              Text('',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  FontWeight.w400,
                  fontFamily:
                  AppTheme.fontName,
                  color: AppTheme.white,
                ),
              )),


        ],

      );
    } else {
      return Wrap();
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

}




class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key key,
      this.categoriesListData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final AllServicesModel categoriesListData;
  final VoidCallback callBack;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return

          FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation.value), 0.0),
              child: AspectRatio(
                aspectRatio: 1.6,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Card(

                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        color: AppTheme.white,
                        elevation: 5,
                        child:
                        Column(
                          children: <Widget>[

                            Container(
                              height: size.height*0.08,
                              width: size.width*0.51,


                              child: Padding(
                                padding: EdgeInsets.all(
                                    15),
                                child:
                                categoriesListData.image!=null?
                                Image.network(
                                  categoriesListData.image,
                                ):Image.asset("assets/images/cbxlogo.png",height: 50,width: 50,),
                              ),
                            ),
                            Text(categoriesListData.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.nearlyBlack,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppTheme.fontName)),

                          ],
                        ),
                      ),
                      // -------------also set Image png/JPG--------------

                      /*Image.asset(
                      categoriesListData.imagePath,
                      fit: BoxFit.cover,
                    ),*/

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.grey.withOpacity(0.2),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {
                            callBack();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          ;
      },
    );
  }
}

class NoDataFound extends StatelessWidget {
  const NoDataFound(
      {Key key})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height*0.25,
          child: Padding(
            padding: EdgeInsets.all(
                5),
            child: Image.asset("assets/images/datanotfound.png")

          ),
        ),
        Text("Services Not Found",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: AppTheme.nearlyBlack,
                fontWeight: FontWeight.w500,
                fontFamily: AppTheme.fontName)),
      ],
    );
  }
}
