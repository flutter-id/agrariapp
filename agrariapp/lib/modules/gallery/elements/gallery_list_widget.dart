import 'package:flutter/material.dart';
import 'package:agrariapp/constants/style_constant.dart';

class GalleryListWidget extends StatelessWidget {
  final List list;
  GalleryListWidget({this.list});
  Widget build(BuildContext context) {
    return Container(
      // child: GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        // child: ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(list[index]['image']),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    list[index]['title'],
                    style: mGridTitleStyle,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
