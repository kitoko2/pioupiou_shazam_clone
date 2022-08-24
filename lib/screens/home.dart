// ignore_for_file: avoid_print

import 'dart:async';

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:avatar_glow/avatar_glow.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:shazam_clone/screens/detailsong.dart';
import 'package:shazam_clone/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

extension on int {
  String toMinute() {
    final res =
        "${DateTime.fromMillisecondsSinceEpoch(this).minute}:${DateTime.fromMillisecondsSinceEpoch(this).second}";
    return res;
  }
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  SongModel? songModel;
  bool record = false;
  double turns = 0.0;
  Timer? timer;
  bool? isOnApp = true;
  void _changeRotation() {
    setState(() => turns += 1.0 / 8.0);
  }

  final AcrCloudSdk arc = AcrCloudSdk();
  void searchSong(SongModel? song) async {
    if (song != null) {
      setState(() {
        songModel = song;
        record = false;
      });
      print(song.metadata!.music![0].artists![0].name);
      var msDurartion = songModel!.metadata!.music![0].durationMs;
      if (songModel!.metadata!.music![0].externalMetadata!.deezer != null) {
        print(
            songModel!.metadata!.music![0].externalMetadata!.deezer!.track!.id);
      }

      _showMyDialog(
        songModel!.metadata!.music![0].album!.name!,
        songModel!.metadata!.music![0].artists![0].name!,
        msDurartion!.toMinute(),
      );
    } else {
      print("Song non trouvé");
    }
  }

  _showMyDialog(String title, String nameArtiste, String time) {
    return Get.bottomSheet(
      SizedBox(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(seconds: 1),
                  child: const Icon(
                    Icons.animation_sharp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        nameArtiste,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6!,
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(time),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      DetailSong(songModel: songModel!),
                      transition: Transition.cupertino,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    width: 50,
                    height: 50,
                    child: const Center(
                      child: Icon(Icons.play_arrow_sharp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      elevation: 20.0,
      enableDrag: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isOnApp!) {
        if (mounted) _changeRotation();
      }
    });
    arc
      ..init(
        host: 'identify-eu-west-1.acrcloud.com',
        accessKey: 'fec83cb144714dca5ae3462e7819b197',
        accessSecret: '1W5LoQkpTl8eGJ1IfpHX6aOovXHWBNpxMqMflikI',
        setLog: false,
      )
      ..songModelStream.listen(searchSong);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        isOnApp = true;
      });
    } else {
      setState(() {
        isOnApp = false;
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            record
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: Text(
                        "Appuyer sur le logo de pioupiou dev pour demarer l'enregistrement autour de vous",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            record
                ? AvatarGlow(
                    endRadius: MediaQuery.of(context).size.width / 2.5,
                    glowColor: primaryColor,
                    duration: const Duration(milliseconds: 1700),
                    showTwoGlows: true,
                    animate: record,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          record = false;
                        });
                        bool stoping = await arc.stop();
                        print("stoping :  $stoping");
                      },
                      child: AnimatedRotation(
                        turns: turns,
                        duration: const Duration(seconds: 1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Image.asset(
                              "assets/IMG-20220811-WA0086.jpg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        record = true;
                      });
                      bool starting = await arc.start();
                      print("starting : $starting");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Image.asset(
                          "assets/IMG-20220811-WA0086.jpg",
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
