import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gallery_widget.dart';
import 'gallery_notifier.dart';

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GalleryNotifier>.value(
          value: GalleryNotifier(),
        )
      ],
      child: GalleryWidget(),
    );
  }
}
