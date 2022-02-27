import 'package:astrotak/bloc/relative_bloc/relatives_bloc.dart';
import 'package:astrotak/bloc/relative_bloc/relatives_event.dart';
import 'package:astrotak/bloc/relative_bloc/relatives_state.dart';
import 'package:astrotak/models/relative_model.dart';
import 'package:astrotak/repository/api_repository.dart';
import 'package:astrotak/services/logger.dart';
import 'package:astrotak/widgets/place_birth.dart';
import 'package:astrotak/widgets/relative_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class NewRelative extends StatefulWidget {
  Relative? oldRelative;
  Function back;
  NewRelative({Key? key, this.oldRelative, required this.back})
      : super(key: key);

  @override
  _NewRelativeState createState() => _NewRelativeState();
}

class _NewRelativeState extends State<NewRelative> {
  final _formKey = GlobalKey<FormState>();
  final _controller = ValueNotifier<bool>(false);
  final _focusNode = FocusNode();

  late final ApiRepository apiRepository;

  String dropdownValueGender = 'MALE';
  int dropdownValueRelation = 1;
  bool _isInit = true;
  var relativeBloc;

  Relative? _relative = Relative(
    birthDetails: BirthDetails(
        dobYear: 2000,
        dobMonth: 01,
        dobDay: 01,
        tobHour: 00,
        tobMin: 00,
        meridiem: "AM"),
    birthPlace: BirthPlace(placeName: "NA", placeId: "NA"),
    dateAndTimeOfBirth: DateTime.now(),
    firstName: "",
    fullName: "",
    gender: "MALE",
    lastName: "",
    middleName: "",
    relation: "Brother",
    relationId: 3,
    uuid: "",
  );

  @override
  void initState() {
    // TODO: implement initState
    relativeBloc = BlocProvider.of<RelativesBloc>(context);
    _controller.addListener(() {
      if (_controller.value) {
        _relative!.birthDetails.meridiem = "AM";
      } else {
        _relative!.birthDetails.meridiem = "PM";
      }
    });
    super.initState();
  }

  void didChangeDependencies() {
    if (widget.oldRelative != null) {
      _relative = widget.oldRelative;
      dropdownValueGender = _relative!.gender;
      dropdownValueRelation = _relative!.relationId;
    }

    super.didChangeDependencies();
  }

  void addBirthPlaceDetails(BirthPlace birthPlace) {
    _relative!.birthPlace = birthPlace;
    logger.i("Addddddd Details------>>>> ${_relative!.birthPlace.placeName}");
  }

  void _saveForm() async {
    logger.i("Saving Form --->>>>");
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    if (_relative!.uuid == "") {
      logger.i("Newwwwww Userrrrrrr");

      logger.i("Adding new relative" + _relative!.toString());
      relativeBloc.add(AddRelative(_relative!));
      widget.back();
      // Navigator.of(context).pop();
    } else {
      relativeBloc.add(UpdateRelative(_relative!));
      widget.back();
      // Navigator.of(context).pop();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              widget.back();
            },
          ),
          title: Text(
            'Add New Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Name',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _relative!.fullName,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusNode);
                      },
                      onSaved: (value) {
                        if (value!.split(" ").length == 2) {
                          _relative!.firstName = value!.split(" ")[0];
                          _relative!.lastName = value.split(" ")[1];
                        } else if (value.split(" ").length >= 3) {
                          _relative!.firstName = value.split(" ")[0];
                          _relative!.lastName = value.split(" ")[2];
                          _relative!.middleName = value.split(" ")[1];
                        }

                        logger.d(
                            "${_relative!.firstName} ${_relative!.lastName}");
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the name';
                        }
                        if (value.split(" ").length < 2) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: _inputDecoration("Enter Name"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Date of Birth',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 125,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            initialValue:
                                _relative!.birthDetails.dobDay.toString(),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid DD';
                              }

                              if (int.parse(value) > 31) {
                                return 'Invalid DD';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _relative!.birthDetails.dobDay =
                                  int.parse(value!);
                            },
                            decoration: _inputDecoration("DD"),
                            maxLength: 2,
                          ),
                        ),
                        SizedBox(
                          width: 125,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            initialValue:
                                _relative!.birthDetails.dobMonth.toString(),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid MM';
                              }
                              if (int.parse(value) > 12) {
                                return 'Invalid MM';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _relative!.birthDetails.dobMonth =
                                  int.parse(value!);
                            },
                            decoration: _inputDecoration("MM"),
                            maxLength: 2,
                          ),
                        ),
                        SizedBox(
                          width: 125,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            initialValue:
                                _relative!.birthDetails.dobYear.toString(),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid YYYY';
                              }

                              if (int.parse(value) < 1000) {
                                return 'Invalid YYYY';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _relative!.birthDetails.dobYear =
                                  int.parse(value!);
                            },
                            maxLength: 4,
                            decoration: _inputDecoration("YYYY"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Time of Birth',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            initialValue:
                                _relative!.birthDetails.tobHour.toString(),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid HH';
                              }

                              if (int.parse(value) > 23) {
                                return 'Invalid HH';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _relative!.birthDetails.tobHour =
                                  int.parse(value!);
                            },
                            maxLength: 2,
                            decoration: _inputDecoration("HH"),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            initialValue:
                                _relative!.birthDetails.tobMin.toString(),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_focusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid MM';
                              }

                              if (int.parse(value) > 59) {
                                return 'Invalid MM';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _relative!.birthDetails.tobMin =
                                  int.parse(value!);
                            },
                            maxLength: 4,
                            decoration: _inputDecoration("MM"),
                          ),
                        ),
                        Container(
                          height: 60,
                          // width: 100,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 18.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _relative!.birthDetails.meridiem = 'AM';
                                    });
                                  },
                                  child: Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: _relative!.birthDetails.meridiem ==
                                              'AM'
                                          ? Color(0xff4b60bd)
                                          : Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "AM",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: _relative!.birthDetails
                                                        .meridiem ==
                                                    'AM'
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _relative!.birthDetails.meridiem = 'PM';
                                      logger
                                          .d(_relative!.birthDetails.meridiem);
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _relative!.birthDetails.meridiem !=
                                              'AM'
                                          ? Color(0xff4b60bd)
                                          : Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        "PM",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _relative!
                                                      .birthDetails.meridiem !=
                                                  'AM'
                                              ? Colors.white
                                              : Colors.black,
                                        ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Place of Birth',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     //
                  //     initialValue: _relative!.birthPlace.placeName,
                  //     onSaved: (newValue) {
                  //       logger.d("Placeeeeeeeeeeeeeeeeeeee");
                  //       String placeId = DateTime.now().toString();

                  //       // logger
                  //       //     .i(newValue + "-----------------------" + placeId);
                  //       _relative!.birthPlace =
                  //           BirthPlace(placeName: newValue!, placeId: placeId);
                  //     },

                  //     decoration: _inputDecoration(" "),
                  //   ),
                  // ),
                  PlaceBirth(
                    addDetails: addBirthPlaceDetails,
                    birthPlace: _relative!.birthPlace,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Gender',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 175,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButton(
                                  value: dropdownValueGender,
                                  isExpanded: true,
                                  underline: Container(),
                                  items: [
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Male'),
                                      ),
                                      value: 'MALE',
                                    ),
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Female'),
                                      ),
                                      value: 'FEMALE',
                                    ),
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Other'),
                                      ),
                                      value: 'OTHER',
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownValueGender = value as String;
                                      _relative!.gender = dropdownValueGender;
                                    });
                                    logger.i(dropdownValueGender);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Relation',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 175,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButton(
                                  value: dropdownValueRelation,
                                  isExpanded: true,
                                  underline: Container(),
                                  items: [
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Father'),
                                      ),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Mother'),
                                      ),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Son'),
                                      ),
                                      value: 6,
                                    ),
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Brother'),
                                      ),
                                      value: 3,
                                    ),
                                    DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Sister'),
                                      ),
                                      value: 4,
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownValueRelation = value as int;

                                      _relative!.relationId =
                                          dropdownValueRelation;
                                    });
                                    logger.i(dropdownValueRelation);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xfffe944c)),
                      onPressed: () {
                        _saveForm();
                      },
                      child: Text('Save Changes'),
                    ),
                  )
                ],
              )),
        ));
  }
}
