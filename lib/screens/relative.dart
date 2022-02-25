import 'package:astrotak/bloc/relative_bloc/relatives_bloc.dart';
import 'package:astrotak/bloc/relative_bloc/relatives_event.dart';
import 'package:astrotak/bloc/relative_bloc/relatives_state.dart';
import 'package:astrotak/models/relative_model.dart';
import 'package:astrotak/screens/new_relative.dart';
import 'package:astrotak/services/logger.dart';
import 'package:astrotak/widgets/relative_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelativeScreen extends StatefulWidget {
  RelativeScreen({Key? key}) : super(key: key);

  @override
  _RelativeScreenState createState() => _RelativeScreenState();
}

class _RelativeScreenState extends State<RelativeScreen> {
  var relativeBloc;

  List<Relative> relatives = [];

  bool _addNew = false;
  bool _isEdit = false;
  late Relative _editedRelative;

  void _deleteRelative(String uuid) {
    relatives.removeWhere((relative) => relative.uuid == uuid);
    logger.i('logger --> ${relatives.length}');
    relativeBloc.add(DeleteRelative(uuid));
    relativeBloc.add(FetchAllRelatives());
  }

  void _updateRelative(Relative relative) {
    _editedRelative = relative;
    setState(() {
      _isEdit = true;
    });

    // relativeBloc.add(FetchAllRelatives());
  }

  void _backToList() {
    setState(() {
      _isEdit = false;
      _addNew = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    relativeBloc = BlocProvider.of<RelativesBloc>(context);
    relativeBloc.add(FetchAllRelatives());

    return BlocBuilder<RelativesBloc, RelativesState>(
        builder: (context, state) {
      logger.i(state);

      if (state is FetchedRelativesState) {
        relatives = state.relatives;
      }

      return Scaffold(
        body: _addNew
            ? NewRelative(
                back: _backToList,
              )
            : _isEdit
                ? NewRelative(
                    oldRelative: _editedRelative,
                    back: _backToList,
                  )
                : state is FetchingRelativesState
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is FetchedRelativesState
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Color(0xffe0e3f3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.wallet_travel,
                                        color: Color(0xff4a5fbc),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text(
                                          "Wallet Balance: ₹0",
                                          style: TextStyle(
                                            color: Color(0xff4a5fbc),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text("Add Money"),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Name",
                                        style: TextStyle(
                                          color: Color(0xff4a5fbc),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 60.0),
                                      child: Text(
                                        "DOB",
                                        style: TextStyle(
                                          color: Color(0xff4a5fbc),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        "TOB",
                                        style: TextStyle(
                                          color: Color(0xff4a5fbc),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        "Relation",
                                        style: TextStyle(
                                          color: Color(0xff4a5fbc),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.ac_unit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: relatives.length,
                                    itemBuilder: (context, index) {
                                      return RelativeTile(
                                        relatives[index],
                                        _deleteRelative,
                                        _updateRelative,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffff944c),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _addNew = true;
                                      });
                                    },
                                    child: Text('+ Add New Profile')),
                              )
                            ],
                          )
                        : state is AddingRelativeState
                            ? Text('Adding')
                            : state is UpdatedRelativeState
                                ? Text('Updating')
                                : Text('Error'),
      );
      // if (state is FetchingRelativesState) {

      // }

      // if (state is FetchedRelativesState) {
      //   relatives = state.relatives;
      //   return Scaffold(
      //     appBar: AppBar(
      //       title: Text('Relatives'),
      //     ),
      //     body: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Expanded(
      //           child: ListView.builder(
      //             itemCount: relatives.length,
      //             itemBuilder: (context, index) {
      //               return RelativeTile(
      //                 relatives[index],
      //                 _deleteRelative,
      //               );
      //             },
      //           ),
      //         ),
      //         ElevatedButton(
      //             onPressed: () {}, child: Text('+ Add New Profile'))
      //       ],
      //     ),
      //   );
      // } else {
      //   logger.i(state);
      //   return Center(
      //     child: Text('No relatives'),
      //   );
    }
        // },
        );
  }
}
