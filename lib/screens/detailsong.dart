// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:shazam_clone/controllers/getdeezercontroller.dart';
import 'package:shazam_clone/screens/loading.dart';
import 'package:shazam_clone/screens/notInDeezerpage.dart';

class DetailSong extends StatefulWidget {
  final SongModel? songModel;
  const DetailSong({Key? key, required this.songModel}) : super(key: key);

  @override
  State<DetailSong> createState() => _DetailSongState();
}

class _DetailSongState extends State<DetailSong> {
  final GetDeezerController _getDeezerController =
      Get.put(GetDeezerController());
  var topsl = 0.0;
  late ScrollController scrollController;
  bool? isInDeezer;
  bool playing = false;
  final player = AudioPlayer();

  chargeMusique(String? url) async {
    if (url != null) {
      await player.setUrl(// Load a URL
          url);
      await player.setLoopMode(LoopMode.one);
    } else {
      Fluttertoast.showToast(msg: "aucune url a lire");
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.songModel!.metadata!.music![0].externalMetadata!.deezer !=
          null) {
        if (mounted) {
          setState(() {
            isInDeezer = true;
          });
        }
        Deezer deezer =
            widget.songModel!.metadata!.music![0].externalMetadata!.deezer!;
        await _getDeezerController.getDataOnDeezer(deezer.track!.id!);
        await chargeMusique(_getDeezerController.deezerModel.value.preview!);
      } else {
        isInDeezer = false;
        if (mounted) {
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_getDeezerController.getIfValueIsInDeeze(
            widget.songModel!.metadata!.music![0].externalMetadata!.deezer)
        ? NotInDeezerPage(songModel: widget.songModel!)
        : Obx(() {
            return _getDeezerController.load.value
                ? const Loading()
                : Scaffold(
                    extendBodyBehindAppBar: true,
                    body: Stack(
                      children: [
                        CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          slivers: [
                            SliverAppBar(
                              expandedHeight: 350,
                              backgroundColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.98),
                              pinned: true,
                              flexibleSpace: LayoutBuilder(
                                builder: ((context, constraints) {
                                  topsl = constraints.biggest.height;
                                  print(topsl);
                                  return FlexibleSpaceBar(
                                    title: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          topsl > 130
                                              ? Text(
                                                  widget.songModel!.metadata!
                                                      .music![0].title!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(fontSize: 15),
                                                )
                                              : FittedBox(
                                                  child: Text(
                                                    widget.songModel!.metadata!
                                                        .music![0].title!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(fontSize: 15),
                                                  ),
                                                ),
                                          if (topsl > 130)
                                            widget
                                                        .songModel!
                                                        .metadata!
                                                        .music![0]
                                                        .artists!
                                                        .length <
                                                    3
                                                ? Text(
                                                    allArtisteName(
                                                      widget
                                                          .songModel!
                                                          .metadata!
                                                          .music![0]
                                                          .artists!,
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                          fontSize: 11,
                                                          color: Colors.grey,
                                                        ),
                                                  )
                                                : SizedBox(
                                                    height: 20,
                                                    child: Marquee(
                                                      accelerationDuration:
                                                          const Duration(
                                                              seconds: 7),
                                                      pauseAfterRound:
                                                          const Duration(
                                                              seconds: 2),
                                                      text: allArtisteName(
                                                        widget
                                                            .songModel!
                                                            .metadata!
                                                            .music![0]
                                                            .artists!,
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .copyWith(
                                                            fontSize: 11,
                                                            color: Colors.grey,
                                                          ),
                                                    ),
                                                  )
                                        ],
                                      ),
                                    ),
                                    background: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: <Color>[
                                            Colors.transparent,
                                            Colors.black87,
                                          ],
                                        ).createShader(bounds);
                                      },
                                      blendMode: BlendMode.darken,
                                      child: Image.network(
                                        _getDeezerController
                                            .deezerModel.value.album!.coverBig!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildDescription(
                                        "Nom de l'album",
                                        widget.songModel!.metadata!.music![0]
                                            .album!.name!),
                                    const Divider(),
                                    buildDescription(
                                      "Date de sorie",
                                      _getDeezerController
                                          .deezerModel.value.releaseDate
                                          .toString(),
                                    ),
                                    const Divider(),

                                    buildDescription(
                                      "Nombre de disque",
                                      _getDeezerController
                                          .deezerModel.value.diskNumber
                                          .toString(),
                                    ),
                                    const Divider(),

                                    buildDescription(
                                      "Type de music",
                                      _getDeezerController
                                          .deezerModel.value.type
                                          .toString(),
                                    ),
                                    const Divider(),

                                    // Text(
                                    //   "Artiste et collaborateur",
                                    //   style:
                                    //       Theme.of(context).textTheme.headline6,
                                    // ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(180),
                                          child: SizedBox(
                                            width: 120,
                                            height: 120,
                                            child: Image.network(
                                              _getDeezerController.deezerModel
                                                  .value.artist!.pictureBig!,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: List.generate(
                                                  _getDeezerController
                                                      .deezerModel
                                                      .value
                                                      .contributors!
                                                      .length, (index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              180),
                                                      child: Image.network(
                                                          _getDeezerController
                                                              .deezerModel
                                                              .value
                                                              .contributors![
                                                                  index]
                                                              .pictureBig!),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    const Divider(),
                                    Center(
                                      child: SizedBox(
                                        width: 250,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.download),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Telecharger",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        buildFab()
                      ],
                    ),
                  );
          });
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

  Widget buildDescription(String titre, String valeur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titre,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 17),
        ),
        Text(
          valeur,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 15,
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildFab() {
    double defaultmargin = 350;
    double defaultstart = 330;
    final double defaulEnd = defaultstart / 2;
    double top = defaultmargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset;
      if (offset < defaultmargin - defaultstart) {
        scale = 1.0;
      } else if (offset < defaultstart - defaulEnd) {
        scale = (defaultmargin - defaulEnd - offset) / defaulEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        child: FloatingActionButton(
          onPressed: () {
            if (playing) {
              player.pause();
              setState(() {
                playing = false;
              });
            } else {
              setState(() {
                playing = true;
              });
              player.play().whenComplete(() {
                print("song complete");

                setState(() {
                  playing = false;
                });
              });
            }
          },
          child: playing
              ? Lottie.asset("assets/animation_black.json", width: 30)
              : const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
