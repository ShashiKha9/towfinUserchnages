import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:dotted_border/dotted_border.dart';

import '../app_theme.dart';

class InviteFriend extends StatefulWidget {

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  Future<String> createDynamicLink() async {
    print("check_ashsih4");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://roadrunnersclub.page.link',
      link: Uri.parse('https://roadrunnersclub.page.link'),
      androidParameters: AndroidParameters(
          packageName: 'com.roadrunnersclub',
          minimumVersion: 1
      ),

    );
    print("check_ashsih3");
    var dynamicUrl = await parameters.buildShortLink();
    print("check_ashsih2:$dynamicUrl");
    final Uri shortUrl = dynamicUrl.shortUrl;
    print("check_ashsih:"+shortUrl.toString());
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
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  r'Refer now & earn 5$ ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: Padding(padding: EdgeInsets.all(10),
                child:Center(
                child: Container(
                  height: 40,
                  width: 120,
                  child:DottedBorder(
                    color: Colors.grey,
                    strokeWidth: 1,
                    child: Center(
                      child:
                      Text("SQ173A",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ),
                ),
                )
              ),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.red,
                        child: InkWell(
                          onTap: () {
                            //method here for functionality
                            // Share.share("https://roadrunnersclub.page.link/u9DC");
                            var shortLink;
                            createDynamicLink().then((result){
                              setState(() {
                                if(result is String){
                                  shortLink = result.toString();
                                  print("check_ashsih123:"+shortLink);
                                  print("check_ashsih1"+shortLink);
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
                                    'Share',
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