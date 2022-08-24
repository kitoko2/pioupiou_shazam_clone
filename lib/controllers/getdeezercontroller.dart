// ignore_for_file: avoid_print

import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shazam_clone/models/deezermodel.dart';

class GetDeezerController extends GetxController {
  var load = true.obs;
  var deezerModel = DeezerModel().obs;

  // @override
  // void onInit() {
  //    getDataOnDeezer(idTrackDeezer);
  //   super.onInit();
  // }
  getIfValueIsInDeeze(Deezer? deezer) {
    if (deezer == null) {
      return false;
    }
    return true;
  }

  getDataOnDeezer(String idTrackDeezer) async {
    print(idTrackDeezer);
    try {
      load.value = true;
      final response =
          await Dio().get("https://api.deezer.com/track/$idTrackDeezer");
      DeezerModel deezerModelResult = DeezerModel.fromJson(response.data);
      print(response.data["album"]["cover_big"]);
      deezerModel.value = deezerModelResult;
      load.value = false;
    } catch (e) {
      print(e.toString());
      load.value = false;
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
