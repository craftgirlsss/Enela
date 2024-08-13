import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:perfume/src/components/global_variable.dart';

class EditLocation extends StatefulWidget {
  const EditLocation({super.key});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  var isLoading = false.obs;
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    marker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Edit Lokasi Saya"),
        actions: [
          TextButton(
            onPressed: (){
              print(_address);
              // getCurrentLocation().then((value) {
              //   myLatitude = value.latitude.toString();
              //   myLongitude = value.longitude.toString();
              // });
            },
            child: const Text("Simpan", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
          )
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _position != null
                ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat ?? 0, long ?? 0),
                zoom: 15,
              ),
              markers: _marker,
            )
                : null,
          ),
          Obx(() => isLoading.value ? const Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.symmetric(vertical: 7), child: Text("Mendapatkan Lokasi Anda"),)
            ],
          )) : Container())
        ],
      ),
      // bottomSheet: BottomSheet(
      //   onClosing: () {
      //
      //   },
      //   builder: (context) {
      //     return Container();
      //   },
      // ),
    );
  }

  double? lat;
  double? long;
  String? myLatitude;
  String? myLongitude;
  Position? _position;
  String? _address;
  String jarak = "", catatan = "", waktu = "";
  double latkantor = -7.26964, longkantor = 112.80511;
  final Set<Marker> _marker = {};

  void marker() async {
    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      _marker.add(
        Marker(
          markerId: const MarkerId("Lokasi saat ini"),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: InfoWindow(
            title: "Posisi Anda Sekarang",
            snippet: _address,
          ),
        ),
      );
    });
    setState(() {
      jarak = Geolocator.distanceBetween(
        latkantor, longkantor, pos.latitude, pos.longitude)
        .floor()
        .toString();
    });
  }

  void _getCurrentLocation() async {
    isLoading.value = true;
    Position position = await _determinePosition();
    String address = await _getAddressFormLatLongOnline(position);
    setState(() {
      _position = position;
      lat = position.latitude;
      long = position.longitude;
      _address = address;
      addressController.text = _address ?? 'Cant find location';
    });
    isLoading.value = false;
    Future.delayed(Duration.zero, (){
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 70,
                        height: 5,
                        padding: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black
                        ),
                      )
                    ),
                    const Text('Apakah benar\nini lokasi anda?', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "SF-PRO-Bold")),
                    const Text('Pastikan lokasi anda benar, terkadang akurasi GPS tidak sesuai dengan tempat anda saat ini', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 15),
                  border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  hintText: 'Alamat Email',
                  prefixIcon: const Icon(Iconsax.gps_outline, color: GlobalVariables.buttonColorGreen),
                  suffixIcon: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: (){},
                    child: const Icon(Iconsax.save_2_outline, color: GlobalVariables.buttonColorGreen,),
                  )
                ),
                autofocus: false,
              ),
              const SizedBox(height: 30),
            ],
          ),
        )
      );
    });

  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getAddressFormLatLongOnline(Position param) async {
    try {
      List<Placemark> placemarkList = await placemarkFromCoordinates(
        param.latitude,
        param.longitude,
      );
      Placemark place = placemarkList[0];
      return _address = "${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      // return _address = "${place.country} ${place.postalCode} ${place.administrativeArea} ${place.subAdministrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare} ${place.subThoroughfare} ${place.name}";
    } catch (e) {
      return "Log error$e";
    }
  }


  Future<Position> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      return Future.error('Location is disabled');
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied){
        return Future.error('Location permission is denied');
      }
    }

    if(locationPermission == LocationPermission.deniedForever){
      return Future.error('Location permission is denied forever');
    }
    return await Geolocator.getCurrentPosition();
  }

  void liveLocation(){
    LocationSettings locationSettings = const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position){
      myLongitude = position.longitude.toString();
      myLatitude = position.latitude.toString();
    });
  }
}
