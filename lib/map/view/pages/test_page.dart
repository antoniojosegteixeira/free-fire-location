import 'package:flutter/material.dart';
import 'package:free_fire_location/notifications/check_nearby_fires.dart';
import 'package:free_fire_location/notifications/notifications.dart';

class Teste extends StatefulWidget {
  Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  int numberOfFires = 0;

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
                setState(() {});
              },
              child: Text('$numberOfFires'),
            ),
            ElevatedButton(
              onPressed: () async {
                await createFireNotification(2);
              },
              child: Text('SHOW NOT'),
            ),
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
