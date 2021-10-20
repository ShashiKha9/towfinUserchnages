
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roadrunner/HomePage/ticketscreen.dart';

class RequestScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child:  Scaffold(
appBar: AppBar(
        backgroundColor: Color(0xffdb0202),
    toolbarHeight: 67,
    title: Text("Requests"),
    ),
      body:
        Column(
          children: [
         Container(
           height: MediaQuery.of(context).size.height*0.3,
             width: MediaQuery.of(context).size.width/0.3,
         child:  Padding(padding: EdgeInsets.only(top: 80,left: 20,right: 20),
             child:Card(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(11),
                   side: BorderSide(color: Colors.white),
                 ),
                 shadowColor: Colors.grey.withOpacity(0.6),
          semanticContainer: true,
             child:Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(padding: EdgeInsets.only(top: 20,left: 20),
                     child: Text("for your queries and concerns\n we reply immediately!",
                       style:TextStyle(color: Colors.grey[700]) ,)

                 ),
                 Padding(padding: EdgeInsets.all(20),
               child:  RaisedButton(onPressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => TicketScreen()),
                 );               },
                   child: Text("raise a ticket"),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(11),
                     side: BorderSide(color: Colors.grey[800]),
                   ),
                   color: Colors.red[500],
                   padding: EdgeInsets.symmetric(horizontal: 45,vertical: 12),
               )
                 )
               ],

             )


             ),
           
           
           
           
            )

         ),
      Padding(padding: EdgeInsets.all(20),
     child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
          side: BorderSide(color: Colors.white),
        ),
        child: ListTile(
          title: Text("My requests"),
          subtitle: Text("check updates on your service requests",
              style:TextStyle(color: Colors.grey[700]) ),
          trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TicketList()),
            );
          },

        ),
      )
      )
          ],
        ),
    )
    );

  }
}