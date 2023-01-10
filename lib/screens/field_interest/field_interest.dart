import 'package:flutter/material.dart';

class FieldInterest extends StatefulWidget {
  const FieldInterest({Key? key}) : super(key: key);
  static const String routeName = "/fieldInterest";

  @override
  _FieldInterestState createState() => _FieldInterestState();
}

class _FieldInterestState extends State<FieldInterest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
    );
  }
}
