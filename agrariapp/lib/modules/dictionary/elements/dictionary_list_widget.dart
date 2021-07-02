import 'package:flutter/material.dart';
import 'package:agrariapp/constants/style_constant.dart';

class DictionaryListWidget extends StatelessWidget {
  final List list;
  DictionaryListWidget({this.list});
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                child: Text(list[index]['term'],
                                    style: mTitleStyle)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                                child: Text(
                              list[index]['description'],
                              style: mTravLogContentStyle,
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
