import 'package:flutter/material.dart';
import 'package:agrariapp/global/global_function.dart' as GlobalFunction;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agrariapp/modules/dictionary/elements/dictionary_list_widget.dart';

class DictionaryWidget extends StatefulWidget {
  const DictionaryWidget({Key key}) : super(key: key);

  @override
  _DictionaryWidgetState createState() => _DictionaryWidgetState();
}

class _DictionaryWidgetState extends State<DictionaryWidget> {
  TextEditingController searchController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  bool storyLogin = false;

  getDictionary() async {
    // var token = await GlobalFunction.getToken();
    var server = await GlobalFunction.getServer();
    if (server == null) {
      return null;
    } else {
      var url = Uri.http(server, '/api/dictionary/' + typeController.text);
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
    searchController.addListener(() {
      setState(() {
        typeController.text = searchController.text;
      });
      print(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final StoryNotifier storyNotifier = Provider.of<StoryNotifier>(context);
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
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.0, style: BorderStyle.none),
                          ),
                          hintText: 'Type to search',
                          // prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            if (snapshot.hasData) {
                              return DictionaryListWidget(
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
                          future: getDictionary(),
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
