import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';

enum Label {
  plumbing('Plumbing'),
  cleaning('Cleaning'),
  acinatorfixer("AC Fixer"),
  exterminator("Exterminator"),
  poolcleaner("Pool Cleaner"),
  assembly("Assembly"),
  repairer("Repairer"),
  installation("Installation"),
  garbageman("Garbage Man");

  const Label(this.label);
  final String label;
}

class NewBusinessPage extends StatefulWidget {
  const NewBusinessPage({super.key});

  @override
  State<NewBusinessPage> createState() => _NewBusinessPageState();
}

class _NewBusinessPageState extends State<NewBusinessPage> {
  final TextEditingController _businessName = TextEditingController();
  final TextEditingController _businessLoc = TextEditingController();
  final TextEditingController _businessDesc = TextEditingController();
  final TextEditingController _businessType = TextEditingController();
  Label? selectedIcon;

  final businesses = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: true,
              title: Text(
                'Business',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 25.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: const Row(
                          children: [
                            Text(
                              'Business Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextFormField(
                          controller: _businessName,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your business name'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: const Row(
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextFormField(
                          controller: _businessLoc,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your location'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: const Row(
                          children: [
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextFormField(
                          controller: _businessDesc,
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: 20,
                          maxLength: 1000,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Enter your description'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      DropdownMenu<Label>(
                        controller: _businessType,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        leadingIcon: const Icon(Icons.search),
                        label: const Text('Icon'),
                        inputDecorationTheme: const InputDecorationTheme(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        onSelected: (Label? icon) {
                          setState(() {
                            selectedIcon = icon;
                          });
                        },
                        dropdownMenuEntries:
                        Label.values.map<DropdownMenuEntry<Label>>(
                              (Label icon) {
                            return DropdownMenuEntry<Label>(
                              value: icon,
                              label: icon.label,
                            );
                          },
                        ).toList(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            businesses
                                .collection('businesses')
                                .doc(auth?.uid)
                                .set({
                              'businessName': _businessName.text,
                              'businessLoc': _businessLoc.text,
                              'businessDesc': _businessDesc.text,
                              'businessType': _businessType.text,
                            });
      
                            Navigator.pop(context);
                          },
                          child: const Text("Create"))
                    ],
                  )),
            )),
      ),
    );
  }
}