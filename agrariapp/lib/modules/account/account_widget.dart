import 'package:flutter/material.dart';
import 'package:agrariapp/constants/style_constant.dart';
import 'package:agrariapp/modules/layout/layout_notifier.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  TextEditingController serverController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LayoutNotifier layoutNotifier = Provider.of<LayoutNotifier>(context);
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'ACCOUNT',
                          style: mTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            'Login',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            layoutNotifier.pageIndex = 5;
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              side: BorderSide(width: 2, color: Colors.blue),
                              primary: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            'Register Now',
                            style: mButtonFont,
                          ),
                          onPressed: () {
                            layoutNotifier.pageIndex = 6;
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              side: BorderSide(width: 2, color: Colors.blue),
                              primary: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
