import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'location_service.dart';
import 'user_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation> (
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
        title: 'GPS Fun!',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: HomeView(),
        ),
      )
    );

  }
}

class HomeView extends StatelessWidget {
  const HomeView ({Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Center(
      child: Text(
          'Location: Lat ${userLocation?.latitude}, Long: ${userLocation?.longitude}'),
    );
  }
}
