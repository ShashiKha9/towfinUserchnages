import 'dart:convert';
import 'dart:io';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:roadrunner/HomePage/AddCard.dart';
import 'package:roadrunner/HomePage/addwalletlist_screen.dart';
import 'package:roadrunner/HomePage/transaction_service.dart';
import 'package:roadrunner/LoginSignup/Login/components/body.dart';
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/bloc/UserProfileBloc.dart';
import 'package:roadrunner/components/rounded_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart' as cardmodel;
import 'package:uuid/uuid.dart';
import '../app_theme.dart';
import '../main.dart';
import 'config.dart';
import 'package:square_in_app_payments/google_pay_constants.dart' as google_pay_constants;

enum PaymentType { giftcardPayment, cardPayment, googlePay, applePay, buyerVerification }

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  _WalletScreenState();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumController = TextEditingController();
  final _emailaddressController = TextEditingController();
  SharedPreferences prefs;
  bool get _chargeServerHostReplaced => chargeServerHost != "REPLACE_ME";

  @override
  void initState() {
    super.initState();

    initPreferences();
    _initSquarePayment();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _mobileNumController.addListener(_printLatestValue);
  }




  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _firstNameController.text = prefs.getString(SharedPrefsKeys.FIRST_NAME);
    _lastNameController.text = prefs.getString(SharedPrefsKeys.LAST_NAME);
    _mobileNumController.text = prefs.getString(SharedPrefsKeys.MOBILE);
    _emailaddressController.text =
        prefs.getString(SharedPrefsKeys.EMAIL_ADDRESS);

    setState(() {});
  }

  _printLatestValue() {
    print("Second text field: ${_mobileNumController.text}");

    // });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    _mobileNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.white,
      appBar:
      AppBar(
        brightness: Brightness.light,
        backgroundColor: AppTheme.white,
        elevation: 0,
        title: Text(
          'Wallet',
          style: TextStyle(
            fontSize: 22,
            color: AppTheme.darkText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        color: AppTheme.white,
                        elevation: 3,
                        child: Container(
                            height: size.height * 0.17,
                            width: size.width * 0.85,
                            decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    AppTheme.colorPrimary,
                                    AppTheme.colorPrimaryDark
                                  ]),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.lerp(
                                      Radius.circular(20), Radius.circular(20), 5),
                                  topLeft: Radius.lerp(
                                      Radius.circular(20), Radius.circular(20), 5),
                                  topRight: Radius.lerp(
                                      Radius.circular(20), Radius.circular(20), 5),
                                  bottomRight: Radius.lerp(
                                      Radius.circular(20), Radius.circular(20), 5)),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Available Balance',
                                        style: TextStyle(
                                            color: AppTheme.white,
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        prefs.getString(SharedPrefsKeys.CURRENCY) +
                                            " " +
                                            prefs.getString(
                                                SharedPrefsKeys.WALLET_BALANCE),
                                        style: TextStyle(
                                            color: AppTheme.white,
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 26),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          AddWalletListScreen(),
                                    ),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  color: AppTheme.white,
                                  elevation: 3,
                                  child: Container(
                                      height: size.height * 0.13,
                                      width: size.height * 0.16,
                                      decoration: new BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.centerLeft,
                                            colors: [AppTheme.white, AppTheme.white]),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.lerp(
                                                Radius.circular(20),
                                                Radius.circular(20),
                                                5),
                                            topLeft: Radius.lerp(Radius.circular(20),
                                                Radius.circular(20), 5),
                                            topRight: Radius.lerp(Radius.circular(20),
                                                Radius.circular(20), 5),
                                            bottomRight: Radius.lerp(
                                                Radius.circular(20),
                                                Radius.circular(20),
                                                5)),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Image.asset(
                                                  'assets/images/addwallet.png',
                                                  width: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Text(
                                                  'Add Amount',
                                                  style: TextStyle(
                                                      color: AppTheme.nearlyBlack,
                                                      fontFamily: AppTheme.fontName,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                color: AppTheme.white,
                                elevation: 3,
                                child: Container(
                                    height: size.height * 0.13,
                                    width: size.height * 0.16,
                                    decoration: new BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          end: Alignment.centerLeft,
                                          colors: [AppTheme.white, AppTheme.white]),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.lerp(Radius.circular(20),
                                              Radius.circular(20), 5),
                                          topLeft: Radius.lerp(Radius.circular(20),
                                              Radius.circular(20), 5),
                                          topRight: Radius.lerp(Radius.circular(20),
                                              Radius.circular(20), 5),
                                          bottomRight: Radius.lerp(
                                              Radius.circular(20),
                                              Radius.circular(20),
                                              5)),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                'assets/images/addwallet.png',
                                                width: 40,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                'Wallet History',
                                                style: TextStyle(
                                                    color: AppTheme.nearlyBlack,
                                                    fontFamily: AppTheme.fontName,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          )),

                      SizedBox(height: 20,),
                      Text('Payment Methods',style: TextStyle(fontFamily: AppTheme.fontName,fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),

                      Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                          color: AppTheme.nearlyBlack,
                          elevation: 3,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(25.0),

                            onTap: () {

                              _onStartCardEntryFlow();

                              /*   Navigator.push<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => AddCard(),
                                ),
                              );
      */
                            },
                            child:

                            Container(
                            height: size.height * 0.07,
                            width: size.width * 0.75,
                            decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.centerLeft,
                                  colors: [AppTheme.white, AppTheme.white]),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.lerp(
                                      Radius.circular(25), Radius.circular(25), 5),
                                  topLeft: Radius.lerp(
                                      Radius.circular(25), Radius.circular(25), 5),
                                  topRight: Radius.lerp(
                                      Radius.circular(25), Radius.circular(25), 5),
                                  bottomRight: Radius.lerp(
                                      Radius.circular(25), Radius.circular(25), 5)),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child:Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: <Widget>[
                                      Text(
                                        "Add Card",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ]),
                                    Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),),
                          ),
                        ),
                      )



                      ],
            ));
          }
        },
      ),
    );
  }

  void _showMyDialog(
    BuildContext context,
    String msg,
    String header,
  ) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(header),
            content: Padding(
              padding: EdgeInsets.all(10),
              child: Text(msg),
            ),
            actions: <Widget>[
              /*CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Cancel")
          ),*/
              CupertinoDialogAction(
                  textStyle: TextStyle(
                      color: Colors.red, fontFamily: AppTheme.fontName),
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Okay",
                    style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        color: AppTheme.colorPrimaryDark),
                  )),
            ],
          );
        });
  }

  Future<void> _onStartCardEntryFlow() async {
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCancelCardEntryFlow,
        collectPostalCode: false);
  }


  void _onCardEntryCardNonceRequestSuccess(cardmodel.CardDetails result) async {
    if (!_chargeServerHostReplaced) {
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
      _showUrlNotSetAndPrintCurlCommand(result.nonce);
      return;
    }
    try {
      // await chargeCard(result);
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
    } on ChargeException catch (ex) {
      InAppPayments.showCardNonceProcessingError(ex.errorMessage);
    }
  }

  void _showUrlNotSetAndPrintCurlCommand(String nonce, {String verificationToken}) {
    String title;
    if (verificationToken != null) {
      title = "Nonce and verification token generated but not charged";
    } else {
      title = "Nonce generated but not charged";
    }
    showAlertDialog(
        context: context,
        title: title,
        content:
        "Check your console for a CURL command to charge the nonce, or replace CHARGE_SERVER_HOST with your server host.");
    printCurlCommand(nonce, verificationToken);
  }

  void printCurlCommand(String nonce, String verificationToken) {
    var hostUrl = 'https://connect.squareup.com';
    if (squareApplicationId.startsWith('sandbox')) {
      hostUrl = 'https://connect.squareupsandbox.com';
    }
    var uuid = Uuid().v4();

    if (verificationToken == null) {
      print(
          'curl --request POST $hostUrl/v2/payments \\'
              '--header \"Content-Type: application/json\" \\'
              '--header \"Authorization: Bearer YOUR_ACCESS_TOKEN\" \\'
              '--header \"Accept: application/json\" \\'
              '--data \'{'
              '\"idempotency_key\": \"$uuid\",'
              '\"amount_money\": {'
              '\"amount\": 500,'
              '\"currency\": \"USD\"},'
              '\"source_id\": \"$nonce\"'
              '}\'');
    } else {
      print('curl --request POST $hostUrl/v2/payments \\'
          '--header \"Content-Type: application/json\" \\'
          '--header \"Authorization: Bearer YOUR_ACCESS_TOKEN\" \\'
          '--header \"Accept: application/json\" \\'
          '--data \'{'
          '\"idempotency_key\": \"$uuid\",'
          '\"amount_money\": {'
          '\"amount\": 500,'
          '\"currency\": \"USD\"},'
          '\"source_id\": \"$nonce\",'
          '\"verification_token\": \"$verificationToken\"'
          '}\'');
    }
  }


  void _onCardEntryComplete() {
    if (_chargeServerHostReplaced) {
      showAlertDialog(
          context: context,
          title: "Your order was successful",
          content:
          "Go to your Square dashboard to see this order reflected in the sales tab.");
    }
  }

  void _onCancelCardEntryFlow() {
    // _showOrderSheet();
  }

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(squareApplicationId);

    var canUseApplePay = false;
    var canUseGooglePay = false;
    if (Platform.isAndroid) {
      await InAppPayments.initializeGooglePay(
          squareLocationId, google_pay_constants.environmentTest);
      canUseGooglePay = await InAppPayments.canUseGooglePay;
    } else if (Platform.isIOS) {
      await _setIOSCardEntryTheme();
      await InAppPayments.initializeApplePay(applePayMerchantId);
      canUseApplePay = await InAppPayments.canUseApplePay;
    }


  }

  Future _setIOSCardEntryTheme() async {
    var themeConfiguationBuilder = cardmodel.IOSThemeBuilder();
    themeConfiguationBuilder.saveButtonTitle = 'Pay';
    themeConfiguationBuilder.errorColor = cardmodel.RGBAColorBuilder()
      ..r = 255
      ..g = 0
      ..b = 0;
    themeConfiguationBuilder.tintColor = cardmodel.RGBAColorBuilder()
      ..r = 36
      ..g = 152
      ..b = 141;
    themeConfiguationBuilder.keyboardAppearance = cardmodel.KeyboardAppearance.light;
    themeConfiguationBuilder.messageColor = cardmodel.RGBAColorBuilder()
      ..r = 114
      ..g = 114
      ..b = 114;

    await InAppPayments.setIOSCardEntryTheme(themeConfiguationBuilder.build());
  }


}
