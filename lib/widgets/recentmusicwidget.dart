import 'dart:convert';

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shazam_clone/controllers/indexcontroller.dart';
import 'package:shazam_clone/models/modelsong.dart';
import 'package:shazam_clone/screens/detailsong.dart';
import 'package:shazam_clone/services/deezermodeldatabase.dart';
import 'package:shazam_clone/utils/colors.dart';
import 'package:shazam_clone/utils/theme.dart';

class RecentMusicWidget extends StatefulWidget {
  final double? width;
  final ModelSong? modelSong;
  final int i;
  const RecentMusicWidget(
      {Key? key, required this.modelSong, required this.width, required this.i})
      : super(key: key);

  @override
  State<RecentMusicWidget> createState() => _RecentMusicWidgetState();
}

class _RecentMusicWidgetState extends State<RecentMusicWidget> {
  IndexSelectedController indexSelectedController =
      Get.put(IndexSelectedController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.transparent,
                  Colors.black,
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode.darken,
            child: GestureDetector(
              onTap: () {
                Get.to(
                  DetailSong(
                    songModel: SongModel.fromJson(
                      widget.modelSong!.songModelencode!,
                    ),
                  ),
                );
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemePerso.colorsSpecial,
                  image: DecorationImage(
                    image: NetworkImage(widget.modelSong!.urlImageAlbum!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8),
                      BlendMode.modulate,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 55,
            width: widget.width,
            child: Row(
              children: [
                SizedBox(
                  width: widget.width! - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.modelSong!.artiseName!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 20),
                      ),
                      Text(
                        widget.modelSong!.songName!,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await DeezerModelBox.box!.deleteAt(widget.i);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      width: 23,
                      height: 23,
                      child: const Center(
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
