import 'package:flutter/material.dart';
import 'package:free_fire_location/notifications/check_nearby_fires.dart';

class Teste extends StatefulWidget {
  Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  int numberOfFires = 0;
  Future<int> checkNearbyFires() async {
    try {
      int numberOfNearbyFires = await CheckNearbyFires().check();
      return numberOfNearbyFires;
    } catch (err) {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$numberOfFires'),
            ElevatedButton(
                onPressed: () async {
                  int fires = await checkNearbyFires();
                  setState(() {
                    numberOfFires = fires;
                  });
                },
                child: Text('$numberOfFires')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/map');
                },
                child: Text('MAP'))
          ],
        ),
      ),
    );
  }
}
