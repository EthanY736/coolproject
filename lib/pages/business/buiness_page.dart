import 'package:flutter/material.dart';

class BusinessPage extends StatefulWidget {
  final String businessName;
  final String businessDesc;
  final String businessLoc;
  final String businessType;
  const BusinessPage(
      {super.key,
      required this.businessName,
      required this.businessDesc,
      required this.businessLoc,
      required this.businessType});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.businessName),),
      body: Column(
        children: [
          Text(widget.businessDesc),
          Text(widget.businessLoc),
          Text(widget.businessType),
        ],
      ),
    );
  }
}
