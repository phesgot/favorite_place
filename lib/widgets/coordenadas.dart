import 'package:flutter/material.dart';

class Coordenadas extends StatelessWidget {
  const Coordenadas({super.key, this.latitude, this.longitude});

  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) ,color: Colors.blue.shade100 ,border: Border.all(width: 1, color: Colors.indigo)),
      child: Column(
        children: [
          const Icon(Icons.south_america_outlined, size: 100, color: Colors.indigo,),
          const Text("Coordenadas Geográficas",  style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w900, fontSize: 18)),
          const SizedBox(height: 10),
          Text("Latitude: ${latitude ?? ""}", style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w900, fontSize: 15)),
          Text("Longitude:${longitude ?? ""}", style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w900, fontSize: 15)),
      
        ],
      ),
    );
  }
}
