import 'package:roadrunner/HomePage/location_type_screen.dart';
import 'package:roadrunner/HomePage/tyrecarselect_screen.dart';
import 'package:roadrunner/Modals/AllServicesModel.dart';
import 'package:roadrunner/Modals/AllSubServicesModel.dart';
import 'package:roadrunner/Modals/categorieslist.dart';
import 'package:roadrunner/Modals/services_response.dart';
import 'package:roadrunner/Modals/sub_services_response.dart';
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/bloc/LoginBloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_theme.dart';

class FuelScreen extends StatefulWidget {
  FuelScreen({Key key, this.serviceName, this.serviceId, this.subServiceId,this.serviceImg})
      : super(key: key);

  final serviceName;
  final serviceId;
  final subServiceId;
  final serviceImg;

  @override
  _FuelScreenState createState() =>
      _FuelScreenState(this.serviceName, this.serviceId, this.subServiceId,this.serviceImg);
}

class _FuelScreenState extends State<FuelScreen> with TickerProviderStateMixin {
  _FuelScreenState(this.serviceName, this.serviceId, this.subServiceId,this.serviceImg);

  AnimationController animationController;
  bool multiple = true;

  String serviceId;
  String subServiceId;
  String serviceImg;
  String serviceName;
  bool _isTowService = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

    initPreferences();
  }

  Future<void> initPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // bloc.fetchAllSubServicesReq(context,prefs.getString(SharedPrefsKeys.ACCESS_TOKEN),prefs.getString(SharedPrefsKeys.TOKEN_TYPE),serviceId);
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: AppTheme.white,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                this.serviceName == '' ? 'CBX' : this.serviceName,
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Vehicle Stuck',
                style: TextStyle(
                  fontSize: 10,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        backgroundColor: AppTheme.white,
        body: Container(
            height: size.height,
            color: AppTheme.white,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(

                    margin: EdgeInsets.all(10),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: AppTheme.white,
                    elevation: 3,
                    child:Container(
                      alignment: Alignment.center,

                    height: size.height*0.20,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              'Is your Vehicle 20 feet or less from road?',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppTheme.darkText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Flexible(

                              child: RadioGroup(onRadioSelect: (String value) {
                                setState(() {
                                  if (value == '1') {
                                    _isTowService = false;
                                  } else {
                                    _isTowService = true;
                                  }
                                });
                              })),
                        ],
                      ),

                    )
                  ),
                  Card(

                    margin: EdgeInsets.all(10),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: AppTheme.white,
                    elevation: 3,
                    child:Container(
                      alignment: Alignment.center,

                    height: size.height*0.30,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              'Choose Fuel Grade',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppTheme.darkText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Flexible(child: RadioGroupOil(onRadioSelect: (String value) {
                            setState(() {
                              if (value == '1') {
                                _isTowService = false;
                              } else {
                                _isTowService = true;
                              }
                            });
                          })),
                        ],
                      ),

                    )
                  ),
                  /*Card(

                    margin: EdgeInsets.all(10),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: AppTheme.white,
                    elevation: 3,
                    child:Container(
                      alignment: Alignment.center,

                    height: size.height*0.30,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              'Choose Fuel Grade',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppTheme.darkText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Flexible(
                              child: RadioGroupMobileOil(onRadioSelect: (String value) {
                                setState(() {
                                  if (value == '1') {
                                    _isTowService = false;
                                  } else {
                                    _isTowService = true;
                                  }
                                });
                              })),
                        ],
                      ),

                    )
                  ),*/



/*
                  Visibility(
                    visible: _isTowService,
                    child: Padding(
                        padding: EdgeInsets.only(top: 0, left: 20),
                        child:

                        Center(
                            child:
                            Column(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50,),

                                SizedBox(height: 10,),
                                Text(
                                  'Your service is being changed\nto tow request.\nDo you want to proceed?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppTheme.fontName,
                                    color: AppTheme.darkText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                              ],
                            )

                        )),

                  )
*/
                ],
              ),
            )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50),
          child:
          ElevatedButton(
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
              child: Text("Continue", style: TextStyle(fontSize: 14)),
            ),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppTheme.colorPrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: AppTheme.colorPrimary)))),
            onPressed: () async => {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => LocationTypeScreen(
                    serviceName: serviceName,
                    serviceId: serviceId,
                    subServiceId: subServiceId,
                  ),
                ),
              )
            },
          ),
        ));
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
}

class RadioGroup extends StatefulWidget {
  const RadioGroup({
    Key key,
    this.onRadioSelect,
  }) : super(key: key);
  final RadioGroupValueCallback onRadioSelect;

  @override
  RadioGroupWidget createState() => RadioGroupWidget(this.onRadioSelect);
}

typedef RadioGroupValueCallback = void Function(String color);

class FruitsList {
  String name;
  int index;

  FruitsList({this.name, this.index});
}

class RadioGroupWidget extends State {
  // Default Radio Button Item
  String radioItem = 'Mango';

  RadioGroupWidget(this.callback);

  RadioGroupValueCallback callback;

  // Group Value for Radio Button.
  int id = 1;

  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "Yes",
    ),
    FruitsList(
      index: 2,
      name: "No",
    ),
  ];
 List<FruitsList> fsList = [
    FruitsList(
      index: 1,
      name: "Regular",
    ),
    FruitsList(
      index: 2,
      name: "Mid Grade",
    ),
    FruitsList(
      index: 3,
      name: "Premium",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('$radioItem', style: TextStyle(fontSize: 23))
        ),*/

        Expanded(
            child: Container(
          child: Column(
            children: fList
                .map((data) => RadioListTile(
                      title: Text("${data.name}"),
                      groupValue: id,
                      value: data.index,
                      onChanged: (val) {
                        setState(() {
                          radioItem = data.name;
                          id = data.index;
                        });

                        print(id.toString());
                        callback(id.toString());
                      },
                    ))
                .toList(),
          ),
        )),
      ],
    );
  }
}

class RadioGroupOil extends StatefulWidget {
  const RadioGroupOil({
    Key key,
    this.onRadioSelect,
  }) : super(key: key);
  final RadioGroupOilValueCallback onRadioSelect;

  @override
  RadioGroupOilWidget createState() => RadioGroupOilWidget(this.onRadioSelect);
}

typedef RadioGroupOilValueCallback = void Function(String color);

class OilOptnList {
  String name;
  int index;

  OilOptnList({this.name, this.index});
}

class RadioGroupOilWidget extends State {
  // Default Radio Button Item
  String radioItem = 'Mango';

  RadioGroupOilWidget(this.callback);

  RadioGroupOilValueCallback callback;

  // Group Value for Radio Button.
  int id = 1;

  List<OilOptnList> fOilList = [
    OilOptnList(
      index: 1,
      name: "Regular",
    ),
    OilOptnList(
      index: 2,
      name: "Mid Grade",
    ),
    OilOptnList(
      index: 2,
      name: "Premium",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('$radioItem', style: TextStyle(fontSize: 23))
        ),*/

        Expanded(
            child: Container(
          child: Column(
            children: fOilList
                .map((data) => RadioListTile(
                      title: Text("${data.name}"),
                      groupValue: id,
                      value: data.index,
                      onChanged: (val) {
                        setState(() {
                          radioItem = data.name;
                          id = data.index;
                        });

                        print(id.toString());
                        callback(id.toString());
                      },
                    ))
                .toList(),
          ),
        )),
      ],
    );
  }
}

class RadioGroupMobileOil extends StatefulWidget {
  const RadioGroupMobileOil({
    Key key,
    this.onRadioSelect,
  }) : super(key: key);
  final RadioGroupMobileOilValueCallback onRadioSelect;

  @override
  RadioGroupWidget createState() => RadioGroupWidget(this.onRadioSelect);
}

typedef RadioGroupMobileOilValueCallback = void Function(String color);

class MobileOilOptnList {
  String name;
  int index;

  MobileOilOptnList({this.name, this.index});
}

class RadioGroupMobileOilWidget extends State {
  // Default Radio Button Item
  String radioItem = 'Mango';

  RadioGroupMobileOilWidget(this.callback);

  RadioGroupMobileOilValueCallback callback;

  // Group Value for Radio Button.
  int id = 1;

  List<MobileOilOptnList> fList = [
    MobileOilOptnList(
      index: 1,
      name: "Yes",
    ),
    MobileOilOptnList(
      index: 2,
      name: "No",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('$radioItem', style: TextStyle(fontSize: 23))
        ),*/

        Expanded(
            child: Container(
          height: 350.0,
          child: Column(
            children: fList
                .map((data) => RadioListTile(
                      title: Text("${data.name}"),
                      groupValue: id,
                      value: data.index,
                      onChanged: (val) {
                        setState(() {
                          radioItem = data.name;
                          id = data.index;
                        });

                        print(id.toString());
                        callback(id.toString());
                      },
                    ))
                .toList(),
          ),
        )),
      ],
    );
  }
}

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 100,
          width: size.width,
          child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.not_interested_outlined,
                color: AppTheme.colorPrimary,
                size: 80,
              )),
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
