import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shazam_clone/models/modelsong.dart';

class DeezerModelBox {
  static final DeezerModelBox instance = DeezerModelBox();
  static Box<ModelSong>? box;

  static init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(ModelSongAdapter());
    box = await Hive.openBox<ModelSong>("deezermodelbox");
    // var values = box.values;
    // if (values == null || values.isEmpty) {
    //   RecipeBox.box.putAll(Map.fromIterable(recipes, key: (e) => e.key(), value: (e) => e));
    // }
  }
}
