import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Container(
        child: Column(
          children: [
            Stack(
              children:[
                Image(image: AssetImage("assets/images/backgroundRed.jpg")),
                Padding(padding: EdgeInsets.only(top: 90,left: 20),
                    child:  Text(("Payment History"),style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.white),)
                ),
        ]
            ),
            Container(
             child: Flexible(
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
            ),
          ],
        ),
      ),
    );
  }
}