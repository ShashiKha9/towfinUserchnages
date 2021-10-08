import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:toast/toast.dart';

import '../app_theme.dart';

class InviteFriend extends StatefulWidget {

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  String Text1 = "SQ172A";
  Future<String> createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://roadrunnersclub.page.link',
      link: Uri.parse('https://roadrunnersclub.page.link'),
      androidParameters: AndroidParameters(
          packageName: 'com.roadrunnersclub',
          minimumVersion: 1
      ),
    );
    var dynamicUrl = await parameters.buildShortLink();
    final Uri shortUrl = dynamicUrl.shortUrl;
    return shortUrl.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/inviteImage.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Invite Your Friends',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: const Text(
                  'Are you one of those who makes everything\n at the last moment?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  r'Refer now & earn $5 ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: Padding(padding: EdgeInsets.all(10),
                child:Center(
                child: Container(
                  height: 47,
                  width: 120,
                  child:DottedBorder(
                    color: Colors.grey,
                    strokeWidth: 1,
                    child: Center(
                      child: Column(
                        children: [
                          Text(Text1,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          InkWell(
                            child: Text("Tap to Copy",style: TextStyle(fontSize: 12,color: Colors.grey),),
                              onTap: (){
                                Clipboard.setData(new ClipboardData(text: Text1)).then((_){
                                  Toast.show("Copied to clipboard", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                });                        }
                          )
                        ],

                        )

                          )

                          )
                          ),
                          ),
                          )
                          ),
                          Expanded(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                          child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: <BoxShadow>[
                          BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child:Material(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: InkWell(
                          onTap: () {
                            //method here for functionality
                            // Share.share("https://roadrunnersclub.page.link/u9DC");
                            var shortLink;
                            createDynamicLink().then((result){
                              setState(() {
                                if(result is String){
                                  shortLink = result.toString();
                                  Share.share(shortLink);
                                }
                              });
                            });
                            },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Refer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}