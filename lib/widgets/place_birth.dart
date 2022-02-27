import 'dart:ui';

import 'package:astrotak/services/logger.dart';
import 'package:flutter/material.dart';
import '../models/relative_model.dart';
import '../repository/api_repository.dart';

class PlaceBirth extends StatefulWidget {
  Function addDetails;
  BirthPlace birthPlace;
  //PlaceBirth({Key? key, required addDetails}) : super(key: key);
  PlaceBirth({required this.addDetails, required this.birthPlace});

  @override
  _PlaceBirthState createState() => _PlaceBirthState();
}

class _PlaceBirthState extends State<PlaceBirth> {
  ApiRepository _apiRepository = ApiRepository();
  bool _isVisible = false;
  bool _isLoading = false;

  InputDecoration _inputDecoration(String hinttext) {
    return InputDecoration(
      hintText: hinttext,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  TextEditingController _placeBirthController = TextEditingController();

  String _placeBirth = "";
  List<BirthPlace> listBirthPlace = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placeBirthController =
        TextEditingController(text: widget.birthPlace.placeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _placeBirthController,
              onSubmitted: (value) async {
                setState(() {
                  _isLoading = true;
                  _isVisible = false;
                });

                listBirthPlace = await _apiRepository.getPlaceIds(value);
                setState(() {
                  logger.d(
                      "Workinggggg ----> " + listBirthPlace.length.toString());
                  _isLoading = false;
                  _isVisible = true;
                  logger.i(_isLoading);
                  logger.i(_isVisible);
                });
              },
              decoration: _inputDecoration(" "),
            ),
          ),

          listBirthPlace.length > 0 && _isVisible
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: listBirthPlace.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(listBirthPlace[index].placeName),
                      onTap: () {
                        setState(() {
                          widget.addDetails(listBirthPlace[index]);
                          // widget.birthPlace = listBirthPlace[index];
                          // logger.i(widget.birthPlace.placeName);
                          _placeBirthController.text =
                              listBirthPlace[index].placeName;
                          _isVisible = false;
                        });
                      },
                    );
                  },
                )
              : _isLoading
                  ? Center(
                      child: Column(
                        children: [
                          // Text('${listBirthPlace.length} ${_isVisible}'),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : Container(),
          // FutureBuilder<List<BirthPlace>>(
          //   future: _apiRepository.getPlaceIds(_placeBirth),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return ListView.builder(
          //         itemCount: snapshot.data!.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             title: Text(snapshot.data![index].placeName),
          //             onTap: () {
          //               widget.birthPlace = snapshot.data![index];

          //               Navigator.pop(context, snapshot.data![index]);
          //             },
          //           );
          //         },
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
