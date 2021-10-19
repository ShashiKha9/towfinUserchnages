import 'package:flutter/material.dart';
import 'package:roadrunner/LoginSignup/Login/components/body.dart';
import 'package:roadrunner/Modals/generate_ticket.dart';
import 'package:roadrunner/bloc/TicketBloc.dart';

class TicketScreen extends StatefulWidget {
  @override
  TicketScreenState createState() => TicketScreenState();
}
  class TicketScreenState extends State<TicketScreen> {
    final _subController = TextEditingController();
    final _desController = TextEditingController();

    @override


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
            FlatButton(
              color: Colors.red,
              child: Text("Raise the request",style: TextStyle(color: Colors.white),),
              onPressed: (){
          bloc.raiseReq(1, _subController.text.toString(), _desController.text.toString(), context);
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






      }
      )

          ],
        ),
      ),

    ),

    );

  }
}

