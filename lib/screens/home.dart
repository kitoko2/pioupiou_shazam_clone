// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ui';

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shazam_clone/screens/detailsong.dart';
import 'package:shazam_clone/screens/dialogscreen.dart';
import 'package:shazam_clone/screens/musicsrecent.dart';
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
    print(song!.status!.code);

    if (song.status!.code == 0) {
      // son retrouvé
      setState(() {
        songModel = song;
        record = false;
      });
      debugPrint("****Nom de l'artiste*****");
      debugPrint(song.metadata!.music![0].artists![0].name);
      var msDurartion = songModel!.metadata!.music![0].durationMs;
      if (songModel!.metadata!.music![0].externalMetadata!.deezer != null) {
        debugPrint("****id deezer*****");

        print(
            songModel!.metadata!.music![0].externalMetadata!.deezer!.track!.id);
      }
      _showMyDialog(
        songModel!.metadata!.music![0].album!.name!,
        songModel!.metadata!.music![0].artists![0].name!,
        msDurartion!.toMinute(),
      );
    } else if (song.status!.code == 1001) {
      // Aucun son entendu
      closeRecord();
      Get.bottomSheet(
        const DialogScreen(
          title: "Aucune musique detectée",
          description:
              "Nous avons entendu aucune musique veuillez réessayer svp",
          asset: "assets/81966-girl-listening-to-music.json",
        ),
        ignoreSafeArea: false,
        useRootNavigator: true,
        isScrollControlled: true,
      );
    } else if (song.status!.code == 3000) {
      // aucune connection
      closeRecord();
      Get.bottomSheet(
        const DialogScreen(
          title: "Aucune connexion internet",
          description:
              "Verifier si le wifi ou les données mobiles sont bien activé et que vous êtes connecté à internet",
          asset: "assets/11645-no-internet-animation.json",
        ),
        ignoreSafeArea: false,
        useRootNavigator: true,
        isScrollControlled: true,
      );
    } else {
      // not definis error
      closeRecord();
    }
  }

  closeRecord() {
    debugPrint("Son non trouvé");
    arc.stop();
    if (mounted) {
      setState(() {
        record = false;
      });
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
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
        if (mounted) {
          _changeRotation();
        }
      }
    });
    arc
      ..init(
        host: dotenv.env['HOST']!,
        accessKey: dotenv.env['ACCESSKEY']!,
        accessSecret: dotenv.env['ACCESSSECRET']!,
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
    // arc.songModelStream.listen((event) { });
    if (mounted) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // StreamBuilder<SongModel>(
                //     stream: arc.songModelStream,
                //     builder: ((context, snapshot) {
                //       if (snapshot.hasData) {
                //         print(snapshot.data!.costTime);
                //         return Text("data");
                //       } else {
                //         return Text("no data");
                //       }
                //     }),),

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
                            debugPrint("stoping :  $stoping");
                          },
                          child: AnimatedRotation(
                            turns: turns,
                            duration: const Duration(seconds: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(180),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Image.asset(
                                  "assets/IMG-20220811-WA0086.jpg",
                                  fit: BoxFit.cover,
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
                          debugPrint("starting : $starting");
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.asset(
                              "assets/IMG-20220811-WA0086.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                // const SizedBox(
                //   height: 50,
                // )
              ],
            ),
          ),
          record
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        const Text(
                          "Appuyer sur le logo de pioupiou dev pour demarer l'enregistrement autour de vous",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                backgroundColor: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.8),
                                builder: (context) {
                                  return ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 15, sigmaY: 15),
                                      child: const MusicsRecent(),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(CupertinoIcons.square_stack_3d_down_right),
                                SizedBox(width: 15),
                                Text("Bibiothèque")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
