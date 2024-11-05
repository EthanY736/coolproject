import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore
import 'package:coding_minds_template/pages/business/buiness_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    as PlatformInterface;

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

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final TextEditingController _businessType = TextEditingController();
  Label? selectedIcon;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: PlatformInterface.LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _businessType.dispose();
    super.dispose();
  }

  // Function to perform search and show the bottom sheet
  void _performSearch(Label selectedLabel) async {
    // Fetch data from Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('businesses')
        .where('businessType', isEqualTo: selectedLabel.label)
        .get();

    List<Map<String, dynamic>> businessResults = querySnapshot.docs
        .map((doc) => {
              'businessName': doc['businessName'],
              'businessLoc': doc['businessLoc'],
              'businessDesc': doc['businessDesc'],
            })
        .toList();

    // Show bottom sheet with the retrieved data
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetContent(selectedLabel, businessResults);
      },
    );
  }

  // Widget to build the bottom sheet content based on Firebase results
  Widget _buildBottomSheetContent(
      Label selectedLabel, List<Map<String, dynamic>> results) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 251, 252, 250),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Search Results for ${selectedLabel.label}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          results.isNotEmpty
              ? ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(), // Adds a smoother scrolling effect
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent, // Customize the icon background color
                    child: const Icon(Icons.business, color: Colors.white),
                  ),
                  title: Text(
                    results[index]['businessName'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        results[index]['businessLoc'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        results[index]['businessDesc'],
                        maxLines: 2, // Limits description to 2 lines
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.blueAccent), // Adds an arrow for better navigation hint
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusinessPage(
                              businessName: results[index]['businessName'],
                              businessDesc: results[index]['businessDesc'],
                              businessLoc: results[index]['businessLoc'],
                              businessType: selectedLabel.label),
                        ),
                      );
                    });
                  },
                ),
              );
            },
          )
              : const Center(
            child: Text(
              'No results found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
              top: 30.0, left: 8.0, bottom: 0.0, right: 8.0),
          child: DropdownMenu<Label>(
            controller: _businessType,
            enableFilter: true,
            requestFocusOnTap: true,
            width: MediaQuery.of(context).size.width - 40,
            leadingIcon: const Icon(Icons.search),
            label: const Text('Job Type'),
            menuStyle: MenuStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(180, 255, 255, 255)),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              fillColor: Color.fromARGB(180, 255, 255, 255),
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red, // Set the border color
                  width: 2.0, // Set the border width
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            onSelected: (Label? icon) {
              setState(() {
                selectedIcon = icon;
              });
              if (icon != null) {
                _performSearch(icon); // Perform search when label is selected
              }
            },
            dropdownMenuEntries:
                Label.values.map<DropdownMenuEntry<Label>>((Label icon) {
              return DropdownMenuEntry<Label>(
                value: icon,
                label: icon.label,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(0, 255, 255, 255)),
                  foregroundColor:
                      MaterialStatePropertyAll(Colors.blue), // Text color
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Set the border radius
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ],
        ),
      ),
    );
  }
}
