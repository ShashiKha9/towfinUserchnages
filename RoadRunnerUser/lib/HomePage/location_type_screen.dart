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
import 'enter_vehicle_details.dart';
import 'home_screen.dart';

class LocationTypeScreen extends StatefulWidget {
  LocationTypeScreen(
      {Key key, this.serviceName, this.serviceId, this.subServiceId,this.subServiceName,this.serviceImg})
      : super(key: key);

  final serviceName;
  final serviceId;
  final subServiceName;
  final subServiceId;
  final serviceImg;

  @override
  _LocationTypeScreenState createState() => _LocationTypeScreenState(
      this.serviceName, this.serviceId, this.subServiceId,this.subServiceName,this.serviceImg);
}

class _LocationTypeScreenState extends State<LocationTypeScreen>
    with TickerProviderStateMixin {
  _LocationTypeScreenState(this.serviceName, this.serviceId, this.subServiceId,this.subServiceName,this.serviceImg);

  AnimationController animationController;
  bool multiple = true;

  String serviceId;
  String subServiceId;
  String serviceName;
  String subServiceName;
  String serviceImg;

  String _selectedLocationType="Home";
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
          title:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                this.serviceName == '' ? '' : this.serviceName,
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.darkText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Location Type',
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
                  Padding(
                    padding: EdgeInsets.only(top: 0, left: 20),
                    child: Text(
                      'Please select your location type for faster service',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Flexible(child: RadioGroup(
                    callback:(String selectedLocationType){

                      setState(() {
                        _selectedLocationType = selectedLocationType;

                      });

                    }

                  ))
                ],
              ),
            )),
        bottomNavigationBar:
        Padding(
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

            optionsData.subServiceName = subServiceName,
            optionsData.locationType = _selectedLocationType,


              if(serviceName=="LOCKOUT"){
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => EnterVehicleDetails(
                      serviceName: serviceName,
                      serviceId: serviceId,
                      subServiceId: subServiceId,
                      subServiceName: subServiceName,
                      serviceImg: serviceImg,
                      locationType: _selectedLocationType,
                    ),
                  ),
                )

              }else if(serviceName=="FUEL"){
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => EnterVehicleDetails(
                      serviceName: serviceName,
                      serviceId: serviceId,
                      subServiceId: subServiceId,
                      subServiceName: subServiceName,
                      serviceImg: serviceImg,
                      locationType: _selectedLocationType,

                    ),
                  ),
                )

              }else if(serviceName=="FLAT TIRE"){
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => TyreSelectScreen(
                      serviceName: serviceName,
                      serviceId: serviceId,
                      subServiceId: subServiceId,
                      subServiceName: subServiceName,
                      serviceImg: serviceImg,
                      locationType: _selectedLocationType,

                    ),
                  ),
                )

              }else
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => EnterVehicleDetails(
                    serviceName: serviceName,
                    serviceId: serviceId,
                    subServiceId: subServiceId,
                    subServiceName: subServiceName,
                    locationType: _selectedLocationType,
                    serviceImg: serviceImg,

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
                  '',
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

typedef IntCallback = Function(String  _selectedLocationType);

class RadioGroup extends StatefulWidget {
  RadioGroup(
      {Key key, this.callback})
      : super(key: key);
  final callback;
  @override
  RadioGroupWidget createState() => RadioGroupWidget(callback);
}

class FruitsList {
  String name;
  int index;

  FruitsList({this.name, this.index});
}

class RadioGroupWidget extends State {
  // Default Radio Button Item
  RadioGroupWidget(this.callback);
  String radioItem = 'Home';

  IntCallback callback;

  // Group Value for Radio Button.
  int id = 1;

  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "Home",
    ),
    FruitsList(
      index: 2,
      name: "Street",
    ),
    FruitsList(
      index: 3,
      name: "Highway Right Shoulder",
    ),
    FruitsList(
      index: 4,
      name: "Highway Left Shoulder *Fast lane*",
    ),
    FruitsList(
      index: 5,
      name: "Parking Lot",
    ),
    FruitsList(
      index: 6,
      name: "Parking Garage",
    ),
    FruitsList(
      index: 7,
      name: "Others",
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
                          callback(radioItem);
                          id = data.index;
                        });
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
