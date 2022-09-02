import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shazam_clone/controllers/indexcontroller.dart';
import 'package:shazam_clone/models/modelsong.dart';
import 'package:shazam_clone/services/deezermodeldatabase.dart';
import "package:hive_flutter/hive_flutter.dart";

import 'package:shazam_clone/widgets/recentmusicwidget.dart';

class MusicsRecent extends StatefulWidget {
  const MusicsRecent({Key? key}) : super(key: key);

  @override
  State<MusicsRecent> createState() => _MusicsRecentState();
}

class _MusicsRecentState extends State<MusicsRecent> {
  ScrollController controller = ScrollController();
  IndexSelectedController indexSelectedController =
      Get.put(IndexSelectedController());

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: ValueListenableBuilder<Box<ModelSong>>(
              valueListenable: DeezerModelBox.box!.listenable(),
              builder: ((context, value, child) {
                final res = value.values.cast<ModelSong>().toList();
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  // transitionBuilder: ((child, animation) {
                  //   final offsetAnimation = Tween<Offset>(
                  //           begin: Offset(1.0, 0.0), end: Offset(0.0, 0))
                  //       .animate(animation);
                  //   return SlideTransition(
                  //     position: offsetAnimation,
                  //     child: child,
                  //   );
                  // }),
                  child: res.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                              "assets/83451-interactive-animation-music-library-music-menu-buttons.json",
                              width: 200,
                            ),
                            // const SizedBox(height: 30),
                            const Text(
                              "Si nous detectons un son, il sera automatiquement ajouté dans votre bibliothèque",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Aucune musique récements écoutées",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 23),
                            ),
                            const SizedBox(height: 30)
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              "Vos musiques récement écouté",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 23),
                            ),
                            const Text(
                              "vous pouvez supprimer les musiques souhaité dans cette liste",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: GridView.builder(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 5),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                controller: controller,
                                itemCount: res.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 200,
                                ),
                                itemBuilder: (context, i) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      var width = constraints.maxWidth;
                                      return GestureDetector(
                                        onTap: () async {},
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: RecentMusicWidget(
                                            modelSong: res[i],
                                            width: width,
                                            i: i,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                width: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
