// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: 100,
        child: Center(
          child: Text('by pioupioudev'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/97952-loading-animation-blue.json",
              width: 120,
            ),
          ],
        ),
      ),
    );
  }
}
