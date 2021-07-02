import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:agrariapp/constants/color_constant.dart';
import 'package:agrariapp/constants/style_constant.dart';
import 'package:agrariapp/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agrariapp/modules/home/elements/category_widget.dart';
import 'package:agrariapp/modules/home/elements/story_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  Widget _widget;
  ScrollController _controller;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<CarouselModel> data = [];

  getCategory() async {
    var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    if (server == null) {
      return null;
    } else {
      var url = Uri.http(server, '/api/category');
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else {
        print(result['message'].toString());
      }
    }
  }

  getStatus() async {
    var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    if (server == null) {
      return null;
    } else {
      var url = Uri.http(server, '/api/status');
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else {
        print(result['message'].toString());
      }
    }
  }

  getStory() async {
    // var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    if (server == null) {
      return null;
    } else {
      var url = Uri.http(server, '/api/post');
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json"
          // 'Authorization': 'Bearer $token',
        },
      );
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        List<CarouselModel> temp = [];
        for (var index = 0; index < result['data'].length; index++) {
          if (this.mounted) {
            temp.add(new CarouselModel(result['data'][index]['image']));
          }
        }
        if (this.mounted) {
          this.setState(() {
            this.data = temp;
          });
        }

        return result;
      } else {
        print(result['message'].toString());
      }
    }
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        controller: _controller,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 24),
            child: Text(
              'Hi!',
              style: mTitleStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 190,
                  child: Swiper(
                    onIndexChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                    autoplay: true,
                    layout: SwiperLayout.DEFAULT,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              data[index].image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: map<Widget>(data, (index, image) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          height: 6,
                          width: 6,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index ? mBlueColor : mGreyColor,
                          ),
                        );
                      }),
                    ),
                    Text(
                      'More...',
                      style: mMoreDiscountStyle,
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 24, bottom: 12),
            child: Text(
              'News Category',
              style: mTitleStyle,
            ),
          ),
          Container(
            height: 205,
            // height: 100,
            margin: EdgeInsets.only(left: 16, right: 8),
            child: FutureBuilder(
              builder: (context, snapshot) {
                // var catLength = snapshot.data['data'].length / 2;
                // var resnum = catLength.ceil();
                // Future.delayed(Duration.zero, () async {
                //   setState(() {
                //     _categoryHeight = resnum * 65;
                //   });
                // });
                if (snapshot.hasError) print(snapshot.error);
                if (snapshot.hasData) {
                  return CategoryWidget(
                    list: snapshot.data['data'],
                  );
                } else {
                  return Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
              future: getCategory(),
            ),
          ),
          _widget != null
              ? _widget
              : SizedBox(
                  height: 1,
                ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 24, bottom: 12),
            child: Text(
              'News',
              style: mTitleStyle,
            ),
          ),
          Container(
              height: 300,
              padding: EdgeInsets.only(left: 16),
              child: FutureBuilder(
                future: getStory(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.hasData) {
                    return StoryWidget(list: snapshot.data['data']);
                  } else {
                    return Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        height: 50,
                        width: 50,
                      ),
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}

class CarouselModel {
  String image;

  CarouselModel(this.image);
}
