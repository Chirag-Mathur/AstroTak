import 'package:astrotak/services/logger.dart';
import 'package:flutter/material.dart';
import './relative.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class RelativeHome extends StatefulWidget {
  RelativeHome({Key? key}) : super(key: key);

  @override
  _RelativeHomeState createState() => _RelativeHomeState();
}

class _RelativeHomeState extends State<RelativeHome> {
  final _controller = ValueNotifier<bool>(false);
  bool _isChild = false;
  bool _isFriends = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _isChild = true;
        } else {
          _isChild = false;
        }

        logger.d("Valueee----->" + _isChild.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double cwidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              "assets/images/icon.png",
              height: 60,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.amber.shade800,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Logout'),
                  style: OutlinedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: Colors.amber[800],
                    padding: EdgeInsets.all(5),
                    side: BorderSide(color: Colors.amber.shade800),
                  ),
                ),
              ),
            ],
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            bottom: TabBar(
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.amber,
              tabs: const <Widget>[
                Tab(
                  text: 'My Profile',
                ),
                Tab(text: 'Order History'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Scaffold(
                body: Column(
                  children: [
                    Container(
                      height: 60,
                      width: cwidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isFriends = false;
                                });
                              },
                              child: Container(
                                width: cwidth * 0.45,
                                decoration: BoxDecoration(
                                  color:
                                      _isFriends ? Colors.white : Colors.amber,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Basic Profile",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: _isFriends
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isFriends = true;
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      _isFriends ? Colors.amber : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                                width: cwidth * 0.45,
                                height: 100,
                                child: Center(
                                  child: Text(
                                    "Friends and Family Profile Profile",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _isFriends
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
                    _isFriends
                        ? Expanded(
                            child: RelativeScreen(),
                          )
                        : Container(
                            child: Text("Parent"),
                          ),
                  ],
                ),
              ),
              Center(
                child: Text("Order History"),
              ),
            ],
          ),
        ));
  }
}
