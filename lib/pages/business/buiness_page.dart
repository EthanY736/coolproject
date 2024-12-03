import 'package:flutter/cupertino.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30)
        ),
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.businessName,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.businessDesc,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          widget.businessLoc,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.business, color: Colors.teal),
                      SizedBox(width: 8),
                      Text(
                        widget.businessType,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
          ),
    );
  }
}
