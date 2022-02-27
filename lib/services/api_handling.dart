import 'dart:convert';

import 'package:astrotak/models/relative_model.dart';

import '../models/question_model.dart';
import 'logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiHandling {
  static const String url = "https://staging-api.astrotak.com/api/";
  static const String token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4ODA5NzY1MTkxIiwiUm9sZXMiOltdLCJleHAiOjE2NzY0NjE0NzEsImlhdCI6MTY0NDkyNTQ3MX0.EVAhZLNeuKd7e7BstsGW5lYEtggbSfLD_aKqGFLpidgL7UHZTBues0MUQR8sqMD1267V4Y_VheBHpxwKWKA3lQ";

  Future<List<Question>> getQuestions() async {
    List<Question> questions = [];

    try {
      Response<String> response = await Dio().get(
        url + "question/category/all",
        options: Options(headers: {
          "Authorization": "Bearer " + token,
        }),
      );

      final parsed = json.decode(response.data ?? "") as Map<String, dynamic>;

      parsed["data"].forEach((question) {
        questions.add(returnQuestion(question));
      });
    } catch (e) {
      logger.e(e);
    }

    logger.i(questions.length);

    return [...questions];
  }

  Future<List<Relative>> getRelatives() async {
    List<Relative> relatives = [];

    try {
      Response<String> response = await Dio().get(
        url + "relative/all",
        options: Options(headers: {
          "Authorization": "Bearer " + token,
        }),
      );
      logger.i(response.data);
      final parsed = json.decode(response.data ?? "") as Map<String, dynamic>;

      parsed["data"]["allRelatives"].forEach((relative) {
        relatives.add(returnRelative(relative));
      });
    } catch (e) {
      logger.e(e);
    }

    logger.i(relatives.length);

    return [...relatives];
  }

  Future<void> addRelative(Relative relative) async {
    String data1 = relativeToJson(relative);
    logger.i(data1);
    try {
      // BirthPlace birthPlace = await getPlaceId(relative.birthPlace);
      // relative.birthPlace = birthPlace;

      logger.i("Hello");
      final response = await Dio().post(url + 'relative',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }),
          data: relativeToJson(relative));
      logger.i(response.data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> updateRelative(Relative relative) async {
    try {
      // BirthPlace birthPlace = await getPlaceId(relative.birthPlace);
      // relative.birthPlace = birthPlace;

      logger.i("------------->>>>>>>>>" + relative.birthPlace.placeName);

      final response = await Dio().post(
        url + 'relative/update/' + relative.uuid.toString(),
        options: Options(headers: {
          "Authorization": "Bearer " + token,
          'Content-Type': 'application/json'
        }),
        data: relativeToJson(relative),
      );
      logger.i(response.data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> deleteRelative(String uuid) async {
    logger.i(uuid + "------------");
    try {
      final response = await Dio().post(
        url + 'relative/delete/' + uuid,
        options: Options(headers: {
          "Authorization": "Bearer " + token,
          'Content-Type': 'application/json'
        }),
      );
      logger.i(response.data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<BirthPlace> getPlaceId(BirthPlace _birthPlace) async {
    BirthPlace birthPlace = _birthPlace;

    logger.i("placeId" + birthPlace.placeName);
    try {
      Response<String> response = await Dio().get(
        url + 'location/place?inputPlace=' + birthPlace.placeName,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
      logger.i(response.data);
      final parsed = json.decode(response.data ?? "") as Map<String, dynamic>;

      List<BirthPlace> placeIds = [];

      logger.d("Forrrr Loop");
      parsed["data"].forEach((element) {
        logger.i(element);
        placeIds.add(BirthPlace(
          placeName: element["placeName"],
          placeId: element["placeId"],
        ));
      });

      birthPlace = placeIds[0];

      logger.i(parsed);
    } catch (e) {
      logger.e(e);
    }

    return birthPlace;
  }

  Future<List<BirthPlace>> getPlaceIdLists(String _birthPlace) async {
    String birthPlace = _birthPlace;

    List<BirthPlace> placeIdList = [];

    logger.i("placeId" + birthPlace);
    try {
      Response<String> response = await Dio().get(
        url + 'location/place?inputPlace=' + birthPlace,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
      logger.i(response.data);
      final parsed = json.decode(response.data ?? "") as Map<String, dynamic>;

      logger.d("Forrrr Loop");
      parsed["data"].forEach((element) {
        logger.i(element);
        placeIdList.add(BirthPlace(
          placeName: element["placeName"],
          placeId: element["placeId"],
        ));
      });

      logger.i(parsed);
    } catch (e) {
      logger.e(e);
    }

    return placeIdList;
  }
}
