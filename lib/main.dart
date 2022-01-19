import 'package:flutter/material.dart';

import 'github_search/github_search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo Redux App'),
        ),
        body: GithubSearch(),
      ),
    );
  }
}
