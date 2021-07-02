import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agrariapp/constants/color_constant.dart';
import 'package:agrariapp/constants/string_constant.dart';
import 'package:agrariapp/modules/layout/layout_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:agrariapp/modules/layout/elements/bottom_navigation_widget.dart';
import 'package:agrariapp/modules/home/home_screen.dart';
import 'package:agrariapp/modules/news/news_screen.dart';
import 'package:agrariapp/modules/dictionary/dictionary_screen.dart';
import 'package:agrariapp/modules/gallery/gallery_screen.dart';
import 'package:agrariapp/modules/account/account_screen.dart';
import 'package:agrariapp/modules/login/login_screen.dart';
import 'package:agrariapp/modules/register/register_screen.dart';
import 'package:agrariapp/modules/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutWidget extends StatefulWidget {
  @override
  _LayoutWidgetState createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  var bottomTextStyle =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), //index 0
    NewsScreen(), //index 1
    DictionaryScreen(), //index 2
    GalleryScreen(), //index 3
    AccountScreen(), //index 4
    LoginScreen(), //index 5
    RegisterScreen(), //index 6
    ProfileScreen(), //index 7
  ];

  setServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('server', server);
  }

  @override
  initState() {
    super.initState();
    setServer();
  }

  @protected
  bool debugBuildingDirtyElements = false;

  @override
  Widget build(BuildContext context) {
    final LayoutNotifier layoutNotifier = Provider.of<LayoutNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mBackgroundColor,
        title: SvgPicture.asset('assets/svg/logo-agraria.svg'),
        elevation: 0,
      ),
      backgroundColor: mBackgroundColor,
      bottomNavigationBar: Container(
          height: 64,
          decoration: BoxDecoration(
            color: mFillColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          child: BottomNavigationWidget()),
      body: _widgetOptions.elementAt(layoutNotifier.pageIndex),
    );
  }
}
