import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_widget.dart';
import 'news_notifier.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsNotifier>.value(
          value: NewsNotifier(),
        )
      ],
      child: NewsWidget(),
    );
  }
}
