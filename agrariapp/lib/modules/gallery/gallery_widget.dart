import 'package:flutter/material.dart';
import 'package:agrariapp/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agrariapp/modules/gallery/elements/gallery_list_widget.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({Key key}) : super(key: key);

  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool storyLogin = false;

  getGallery() async {
    // var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    if (server == null) {
      return null;
    } else {
      var url = Uri.http(server, '/api/gallery');
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json"
          // 'Authorization': 'Bearer $token',
        },
      );
      var result = json.decode(response.body);
      print(result);
      if (response.statusCode == 200) {
        return result;
      } else {
        print(result['message'].toString());
      }
    }
  }

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final GalleryNotifier storyNotifier = Provider.of<GalleryNotifier>(context);
    // final LayoutNotifier layoutNotifier = Provider.of<LayoutNotifier>(context);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            if (snapshot.hasData) {
                              return GalleryListWidget(
                                list: snapshot.data['data'],
                              );
                            } else {
                              return SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                          future: getGallery(),
                        ),
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
