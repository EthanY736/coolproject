import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart' as PlatformInterface;
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

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
  late HomePageModel _model;
  final TextEditingController _businessType = TextEditingController();
  Label? selectedIcon;
  TextEditingController _searchController = TextEditingController();
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: PlatformInterface.LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: PlatformInterface.LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 8.0, bottom: 0.0, right: 8.0),
            child: DropdownMenu<Label>(
              controller: _businessType,
              enableFilter: true,
              requestFocusOnTap: true,
              width: MediaQuery.of(context).size.width - 80,
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
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: Stack(
            children: [GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),]
          ),
        ),
      ),
    );
  }
}