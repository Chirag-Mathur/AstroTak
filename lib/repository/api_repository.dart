import 'package:astrotak/models/relative_model.dart';

import '../services/api_handling.dart';

class ApiRepository {
  ApiHandling _apiHandling = ApiHandling();

  getAllQuestions() async {
    return await _apiHandling.getQuestions();
  }

  getAllRelatives() async {
    return await _apiHandling.getRelatives();
  }

  addRelative(Relative relative) async {
    return await _apiHandling.addRelative(relative);
  }

  deleteRelative(uuid) async {
    return await _apiHandling.deleteRelative(uuid);
  }

  updateRelative(Relative relative) async {
    return await _apiHandling.updateRelative(relative);
  }

  getPlaceIds(String _birthPlace) async {
    return await _apiHandling.getPlaceIdLists(_birthPlace);
  }
}
