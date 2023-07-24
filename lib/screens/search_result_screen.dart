import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  String id;

  SearchResultScreen(this.id);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
