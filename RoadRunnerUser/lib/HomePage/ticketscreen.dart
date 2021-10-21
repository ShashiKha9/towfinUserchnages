
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roadrunner/LoginSignup/Login/components/body.dart';
import 'package:roadrunner/Modals/generate_ticket.dart';
import 'package:roadrunner/Modals/ticket_list_response.dart';
import 'package:roadrunner/Utils/helperutils.dart';
import 'package:roadrunner/bloc/TicketBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketScreen extends StatefulWidget {
  @override
  TicketScreenState createState() => TicketScreenState();

}
  class TicketScreenState extends State<TicketScreen> {
    final _subController = TextEditingController();
    final _desController = TextEditingController();
    Timer timer;



    @override
    void initState() {

      super.initState();


      initPreferences();


    }



    Future<void> initPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bloc.ticketlist(1, prefs.getString(SharedPrefsKeys.ACCESS_TOKEN),prefs.getString(SharedPrefsKeys.TOKEN_TYPE) , context);
      // timer =
      //     Timer.periodic(Duration(seconds: 2), (Timer t) =>     ticketlist(context, prefs.getString(SharedPrefsKeys.ACCESS_TOKEN),prefs.getString(SharedPrefsKeys.TOKEN_TYPE)));



      setState(() {

      });

    }




  Widget build(BuildContext context) {
    return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdb0202),
        toolbarHeight: 67,
        title: Text("Requests"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 80,),
          child:  Text("Please describe request to us in the section below")
            ),

            StreamBuilder<GenerateTicket>(
                stream: bloc.raiseRequest.stream,
                builder: (context,snap){
                  return
                   Padding(padding: EdgeInsets.all(20),
                      child:   TextField(
                        controller: _subController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            )
                        ),
                      )
                  );
                }
            ),

            Padding(padding: EdgeInsets.all(20),
                child:   TextField(
                  controller: _desController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 70),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),

                      )
                  ),
                )
            ),



            StreamBuilder<GenerateTicket>(builder:(context,snap){
            return  FlatButton(
                  color: Colors.red,
                  child: Text("Raise the request",style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    // bloc.raiserequest(1, _subController.text.toString(), _desController.text.toString(),prefs.getString(SharedPrefsKeys.ACCESS_TOKEN,),prefs.getString(SharedPrefsKeys.TOKEN_TYPE), context);
                    if (_subController.text.toString().isEmpty)
                    {
                      showAlertDialog(
                          context: context,
                          title: "Enter Your Service",
                          content: "Please Enter Your Service",
                          defaultActionText: "OK");
                    }
                    else if (_desController.text.toString().isEmpty)
                    {
                      showAlertDialog(
                          context: context,
                          title: "Enter the issue",
                          content: "Please Enter Your issue",
                          defaultActionText: "OK");
                    }
                    else{
                      bloc.raiserequest(1, _subController.text.toString(), _desController.text.toString(),prefs.getString(SharedPrefsKeys.ACCESS_TOKEN,),prefs.getString(SharedPrefsKeys.TOKEN_TYPE) ,context);
                      if(snap.hasData){
                       snap.data.code.toString();
                      Text(snap.data.msg.toString()) ;


                      }

                    }






                  }
              );
            }

            )

          ],
        ),
      ),

    ),

    );

  }
}
class TicketList extends StatefulWidget {

  TicketListState createState() => TicketListState();
}
  class TicketListState extends State<TicketList>{

    @override
    void initState() {

      super.initState();


      initPreferences();


    }



    Future<void> initPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bloc.ticketlist(1, prefs.getString(SharedPrefsKeys.ACCESS_TOKEN),prefs.getString(SharedPrefsKeys.TOKEN_TYPE) , context);
      // timer =
      //     Timer.periodic(Duration(seconds: 2), (Timer t) =>     ticketlist(context, prefs.getString(SharedPrefsKeys.ACCESS_TOKEN),prefs.getString(SharedPrefsKeys.TOKEN_TYPE)));



      setState(() {

      });

    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
       child: DefaultTabController(length: 2,
        child: Scaffold(
        appBar: AppBar(
        // shape: Border(
        //     bottom: BorderSide(color: AppTheme.colorPrimary, width: 2)),
        backgroundColor: Colors.red,
        elevation: 3,
        title: Text(
        'My Requests',
        style: TextStyle(
          color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w700,
    ),
    ),
    bottom:  TabBar(
    indicatorColor: Colors.white,
    labelPadding: EdgeInsets.all(10),
    tabs: [
    Text("Active Dispute",style: TextStyle(
    color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),
    Text("Past Dispute",style: TextStyle(
    color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),)
    ]),
    ),
            body:  TabBarView(children: [
              Padding(padding: EdgeInsets.only(top: 40),
            child:  Flexible(
              child: StreamBuilder(builder: (context,snap) {
                return FutureBuilder<bool>(
                  future: postData(),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return Text("No active requests");
                      }
                      else {
                        return ListView.separated(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          itemCount: 7,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(height: 3,
                                thickness: 1,
                                indent: 8,
                                endIndent: 8,
                              ),
                          itemBuilder: (BuildContext context, int index) {
                            return
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: Colors.black),
                                ),
                                shadowColor: Colors.grey.withOpacity(0.6),
                                child: Column(
                                  children: <Widget>[
                                ListTile(
                                      title: Text(
                                        snap.data.toString(), style: TextStyle(
                                          fontWeight: FontWeight.w700),),
                                      subtitle: Text("Status"),
                                      trailing: Text(
                                        "Date & time", style: TextStyle(
                                          fontWeight: FontWeight.w700
                                      ),),
                                    ),
                                  ],
                                ),
                              );
                          },
                        );
                      }
                    }

                );
              }
              )
              ),
              ),
              Padding(padding: EdgeInsets.only(top: 40),
           child:   Flexible(
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    itemCount: 7,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(height: 3,
                          thickness: 1,
                          indent: 8,
                          endIndent: 8,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.black),
                          ),
                          shadowColor: Colors.grey.withOpacity(0.6),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text("Tire Service",style: TextStyle(
                                    fontWeight: FontWeight.w700),),
                                subtitle: Text("xgdgdgdgdgdggg"),
                                trailing: Text(r"$100",style: TextStyle(
                                    fontWeight: FontWeight.w700
                                ),),
                              ),
                            ],
                          ),
                        );
                    },
                  )
              )
              )
            ]),
    )
       )
    );

  }


}
Future<bool> postData() async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 0));
  return true;
}


