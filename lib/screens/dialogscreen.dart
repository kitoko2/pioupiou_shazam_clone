import 'dart:ui';

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DialogScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final String? asset;
  final bool? isFullPage;
  const DialogScreen(
      {Key? key,
      required this.asset,
      required this.description,
      required this.title,
      this.isFullPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(10),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    description!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 220,
                    child: Lottie.asset(asset!),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: isFullPage! ? 25 : 10,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
