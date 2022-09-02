// ignore_for_file: file_names

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:shazam_clone/utils/theme.dart';

class NotInDeezerPage extends StatefulWidget {
  final SongModel? songModel;
  const NotInDeezerPage({Key? key, required this.songModel}) : super(key: key);

  @override
  State<NotInDeezerPage> createState() => _NotInDeezerPageState();
}

class _NotInDeezerPageState extends State<NotInDeezerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 130,
              child: Lottie.asset('assets/7308-empty.json'),
            ),
            Text(
              widget.songModel!.metadata!.music![0].album!.name!,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 20,
              child: Marquee(
                text: allArtisteName(
                    widget.songModel!.metadata!.music![0].artists!),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Vous ne pouvez pas ecouter ce song car il ne figure pas dans notre base",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: ThemePerso.colorsSpecial),
                child: const Icon(Icons.close),
              ),
            )
          ],
        ),
      ),
    );
  }

  String allArtisteName(List<Artists> artists) {
    String name = "";
    for (var artist in artists) {
      if (artist != artists.last) {
        name += "${artist.name!} , ";
      } else {
        name += artist.name!;
      }
    }
    return name;
  }
}
