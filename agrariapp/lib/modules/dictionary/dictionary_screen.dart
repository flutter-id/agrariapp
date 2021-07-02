import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dictionary_widget.dart';
import 'dictionary_notifier.dart';

class DictionaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DictionaryNotifier>.value(
          value: DictionaryNotifier(),
        )
      ],
      child: DictionaryWidget(),
    );
  }
}
