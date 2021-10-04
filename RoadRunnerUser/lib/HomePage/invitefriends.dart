import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../app_theme.dart';

class InviteFriend extends StatefulWidget {

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  Future<void> createDynamicLink() async {
    var parameters = DynamicLinkParameters(
      uriPrefix: 'https://roadrunnersclub/refer',
      link: Uri.parse('https://roadrunnersclub.page.link/u9DC'),
      androidParameters: AndroidParameters(
        packageName: "com.roadrunnersclub",
      ),
    );
    var dynamicUrl = await parameters.buildUrl();
    var shortLink = await parameters.buildShortLink();
    var shortUrl = shortLink.shortUrl;



    @override
    void initState() {
      super.initState();
      this.createDynamicLink();
    }
    void initDynamicLinks(BuildContext context) async {
      await Future.delayed(Duration(seconds: 3));
      var data = await FirebaseDynamicLinks.instance.getInitialLink();
      var deepLink = data?.link;
      final queryParams = deepLink.queryParameters;
      if (queryParams.length > 0) {
        var userName = queryParams['userId'];
      }
      FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink)
      async {
        var deepLink = dynamicLink?.link;
        debugPrint('DynamicLinks onLink $deepLink');
      }, onError: (e) async {
        debugPrint('DynamicLinks onError $e');
      });
    }
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
                            Share.share("https://roadrunnersclub.page.link/u9DC");

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