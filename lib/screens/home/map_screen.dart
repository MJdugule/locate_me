import 'package:flutter/material.dart';
import 'package:locate_me/models/theme_model.dart';
import 'package:locate_me/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_me/screens/home/directions_respository.dart';
import 'directions_model.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(6.264092, 6.201883),
    zoom: 11.5,
  );
  GoogleMapController? _googleMapController;

  Marker? _origin;

  Marker? _destination;
  Directions? _info;

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade300,
            title: Text(
              'LocateMe',
              style: TextStyle(
                color:
                    themeNotifier.isDark ? Colors.blue.shade700 : Colors.orange,
              ),
            ),
            elevation: 0,
            leading: ElevatedButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    themeNotifier.isDark ? Icons.nightlight : Icons.wb_sunny,
                    color: themeNotifier.isDark
                        ? Colors.blue.shade700
                        : Colors.orange,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    themeNotifier.isDark ? 'Dark Mode' : 'Light Mode',
                    style: TextStyle(
                      fontSize: 8,
                      color: themeNotifier.isDark
                          ? Colors.blue.shade700
                          : Colors.orange,
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade300),
              ),
              onPressed: () {
                themeNotifier.isDark
                    ? themeNotifier.isDark = false
                    : themeNotifier.isDark = true;
              },
            ),
            actions: [
              if (_origin != null)
                TextButton(
                  onPressed: () => _googleMapController?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: _origin!.position,
                        zoom: 14.5,
                        tilt: 50.0,
                      ),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Origin'),
                ),
              if (_destination != null)
                TextButton(
                    onPressed: () => _googleMapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: _destination!.position,
                              zoom: 14.5,
                              tilt: 50.0,
                            ),
                          ),
                        ),
                    style: TextButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    child: const Text('Destination')),
              ElevatedButton(
                onPressed: () async {
                  Authentication().logOut(context);
                },
                child: Text('Logout',
                    style: TextStyle(
                      fontSize: 14,
                      color: themeNotifier.isDark
                          ? Colors.blue.shade700
                          : Colors.orange,
                    )),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade300),
                ),
              ),
            ],
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              if (_info != null)
                Positioned(
                  top: 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      '${_info?.totalDistance}, ${_info?.totalDuration}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (controller) => _googleMapController = controller,
                mapType: MapType.hybrid,
                initialCameraPosition: _initialCameraPosition,
                markers: {
                  if (_origin != null) _origin!,
                  if (_destination != null) _destination!,
                },
                onLongPress: _addMaker,
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: _info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              if (_info != null)
                Positioned(
                  top: 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      '${_info?.totalDistance}, ${_info?.totalDuration}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () {
              _googleMapController?.animateCamera(
                _info != null
                    ? CameraUpdate.newLatLngBounds(_info!.bounds, 100)
                    : CameraUpdate.newCameraPosition(_initialCameraPosition),
              );
            },
            child: const Icon(Icons.center_focus_strong),
          ),
        );
      },
    );
  }

  void _addMaker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );

        _destination = null;
        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: "Destination"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      final directions = await DirectionsRespository()
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() {
        _info = directions;
      });
    }
  }
}
