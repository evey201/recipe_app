import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes() async {
    String path = "recipes/";
    final response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      // print(response?.data);
      List data = response!.data["recipes"];
      List<Recipe> recipes =
          data.map((recipe) => Recipe.fromJson(recipe)).toList();
      // print(recipes);
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
