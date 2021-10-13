
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RatingReviewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
          Padding(padding: EdgeInsets.only(top: 60,left: 20),
    child:  Text("Rating&Reviews",style: TextStyle(
    fontSize: 32,fontWeight: FontWeight.w700),)
    ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(left:20),
                    child:
                    Text("4.3",style: TextStyle(fontSize: 45,fontWeight: FontWeight.w700),
                    )
                ),
                    Padding(padding: EdgeInsets.only(left:20),
                        child:
                        Text("32 ratings",style: TextStyle(fontSize: 15),
                        )
                    ),
      ]
    ),
                Padding(padding: EdgeInsets.only(right: 20),
               child: new LinearPercentIndicator(
                  width: 140.0,
                  lineHeight: 10.0,
                  percent: 0.9,
                  backgroundColor: Colors.white,
                  progressColor: Colors.red,
                ),
    )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(padding: EdgeInsets.all(20),
           child: Text("8 reviews",style: TextStyle(
               fontWeight: FontWeight.w700,fontSize: 24),)
            ),
            Container(
                child: Flexible(
                  child:ListView.builder(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      itemCount: 8,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return
                        Container(
                        height:MediaQuery.of(context).size.height*0.25,
                        child:  Card(
                          semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.white),
                            ),
                            shadowColor: Colors.grey.withOpacity(0.6),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading:
                                    ClipRRect(
                                     borderRadius: BorderRadius.all(Radius.circular(4)),
                                     child: Container(
                                       height: 30,
                                       width: 45,
                                       color: Colors.red,
                                      child: Center(
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("4",style: TextStyle(color: Colors.white),),
                                              Icon(Icons.star,size: 18,color: Colors.white,)
                                            ],
                                          )
                                      )
                                     ),
                                    ),

                                  title: Text("Person Name",style: TextStyle(
                                      fontWeight: FontWeight.w700),),
                                  subtitle: Text("Review"),
                                  trailing: Text("Sep 9,2021",style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    color: Colors.grey.withOpacity(0.6)
                                  ),),
                                ),
                              ],
                            ),
                          )
                        );
                      },
                    )
                )
            ),


          ]

        ),




      )
    )
    );
  }
}