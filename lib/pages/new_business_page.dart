import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_minds_template/backend/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../flutter_flow/flutter_flow_theme.dart';

enum Label {
  plumbing("Plumbing"),
  cloud("Cloud"),
  brush("Brush"),
  heart("Heart");

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

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;

  String selectedPlace = ''; // Store the selected place
  Object? latitude;
  Object? longitude;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      // Business Name
                      _buildLabelText('Business Name'),
                      _buildTextFormField(_businessName, 'Enter your business name'),

                      const SizedBox(height: 20),

                      // Location
                      _buildLabelText('Location'),
                      _buildGooglePlacesAutoCompleteField(),

                      const SizedBox(height: 20),

                      // Description
                      _buildLabelText('Description'),
                      _buildTextFormField(
                          _businessDesc,
                          'Enter your description',
                          multiline: true
                      ),

                      const SizedBox(height: 20),

                      // Business Type
                      DropdownMenu<Label>(
                        controller: _businessType,
                        enableFilter: true,
                        requestFocusOnTap: true,
                        width: MediaQuery.of(context).size.width - 40,
                        leadingIcon: const Icon(Icons.search),
                        label: const Text('Job Type'),
                        inputDecorationTheme: const InputDecorationTheme(
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        onSelected: (Label? icon) {
                          setState(() {
                            selectedIcon = icon;
                          });
                        },
                        dropdownMenuEntries: Label.values.map<DropdownMenuEntry<Label>>(
                              (Label icon) {
                            return DropdownMenuEntry<Label>(
                              value: icon,
                              label: icon.label,
                            );
                          },
                        ).toList(),
                      ),

                      const SizedBox(height: 30),

                      // Save Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade700,
                        ),
                        onPressed: () {
                          db.collection('businesses').doc(auth?.uid).set({
                            'businessName': _businessName.text,
                            'businessLoc': selectedPlace, // Use selected place
                            'businessDesc': _businessDesc.text,
                            'businessType': _businessType.text,
                            'businessLong': longitude,
                            'businessLat': latitude
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      )
                    ],
                  )),
            )),
      ),
    );
  }

  // Widget for label text
  Widget _buildLabelText(String label) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for text fields
  Widget _buildTextFormField(TextEditingController controller, String hintText, {bool multiline = false}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: TextFormField(
        controller: controller,
        keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
        minLines: multiline ? 5 : 1,
        maxLines: multiline ? 20 : 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }

  // Google Places Autocomplete field for location
  Widget _buildGooglePlacesAutoCompleteField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: _businessLoc,
        googleAPIKey: "AIzaSyBT_f7ze1ht6LxWU5XY5np8cviYtt4LdPU",  // Add your API key here
        inputDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your location",
        ),
        debounceTime: 600,
        countries: const ["US"], // Customize based on your country requirements
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          setState(() {
            selectedPlace = prediction.description ?? '';
            latitude = prediction.lat ?? 0.0;
            longitude = prediction.lng ?? 0.0;
          });
        },
        itemClick: (Prediction prediction) {
          _businessLoc.text = prediction.description ?? '';
          setState(() {
            selectedPlace = prediction.description ?? '';
          });
        },
      ),
    );
  }
}