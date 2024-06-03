import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/google_map/get/google_map_controller.dart';

import '../../core/constants/place_holders.dart';
import 'builder_ids.dart';

class GoogleMapViewWidget extends StatelessWidget {
  var didShowDirectionButton = false;
  LatLng destinationPoints = const LatLng (0.0,0.0);
  var showDestinationPolyLines = false;


  GoogleMapViewWidget({Key? key, this.didShowDirectionButton = false, this.destinationPoints = const LatLng(0.0,0.0),
  this.showDestinationPolyLines = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleMapScreenController>(
        id: updateGoogleMapScreen,
        builder: (googleMapScreenController) {
          return Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('polyline'),
                      color: Colors.blue,
                      points: googleMapScreenController.polyLines,
                      width: 3,
                    )
                  },
                  markers: googleMapScreenController.locationMarkers,
                  onMapCreated: (controller) {
                    googleMapScreenController.googleMapController = controller;
                    googleMapScreenController.locateUserCurrentPositionOnMap(
                      didPolyLinesShow: showDestinationPolyLines,
                      destination: destinationPoints
                    );
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(45.521563, -122.677433),
                    zoom: 12.0,
                  ),
                ),
                Visibility(
                  visible: didShowDirectionButton,
                  child: Positioned(
                      left: 12,
                      bottom: 12,
                      child: GestureDetector(
                        onTap: () async {
                          final availableMaps =
                          await MapLauncher.installedMaps;

                          await availableMaps.first.showDirections(
                              destination: Coords(destinationPoints.latitude, destinationPoints.longitude));

                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.directions_outlined,
                                  color: Colors.black,
                                ),
                                sizeHorizontalFieldMinPlaceHolder,
                                const CustomTextWidget(text: 'Direction',colorText: Colors.black,),
                              ],
                            ),
                          ),
                        ),
                      )),
                )
              ],
          );
        });
  }
}
