// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rapido/AllWidgets/Divider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => HomePageState();
}

class HomePageState extends State<Homepage> {
  final User? user = FirebaseAuth.instance.currentUser;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  bool _isDragging = false;
  Offset _offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle, color: Colors.black),
                      SizedBox(width: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${user!.phoneNumber}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("History", style: TextStyle(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Visit Profile", style: TextStyle(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(context, '/visit_profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About", style: TextStyle(fontSize: 15)),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout", style: TextStyle(fontSize: 15)),
              onTap: () {
                signOut();
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Text(
              "${user!.phoneNumber}",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: _isDragging ? _offset.dy : 0.0,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _isDragging = true;
                  _offset = Offset(0, _offset.dy + details.delta.dy / 2); // Adjust the speed
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _isDragging = false;
                });
              },
              child: Container(
                height: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16,
                      spreadRadius: 0.6,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 4,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              spreadRadius: 0.6,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.yellowAccent),
                            hintText: "Search Drop off",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Home"),
                              SizedBox(height: 4),
                              Text(
                                "Your Living home address",
                                style: TextStyle(color: Colors.black54, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DividerWidget(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.work, color: Colors.grey),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Work"),
                              SizedBox(height: 4),
                              Text(
                                "Your office address",
                                style: TextStyle(color: Colors.black54, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
