
import 'package:blackcoffer1/Screens/uploads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Global/global.dart';
import '../Helpers/firebase.dart';
import 'explore_screen.dart';
import 'post_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.uid})
      : super(key: key);
  final String uid;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  late String uid = '';

  void setUID(String getUID) {
    uid = getUID;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = widget.uid;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Videos",style: TextStyle(fontSize: 24,color: Colors.black, fontWeight: FontWeight.bold),),
          actions: [
            GestureDetector(
              onTap: () {
                FireHelp().fireSignOut();
                Navigator.pop(context);
                SystemNavigator.pop();
              },
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(top: 10, bottom: 10, right: 14),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: Global.neuShadowsCircular,
                      color: Global.bgColor
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Global.darkColor,
                  )),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          ExploreScreen(uid: uid),
          PostScreen(
            uid: uid,
          ),
          UploadScreen(uid: uid),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: 100,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            boxShadow: Global.neuShadows,

            color: Global.bgColor,

            borderRadius: BorderRadius.circular(15.0),
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              });
            },
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            selectedItemColor: Colors.black,
            selectedLabelStyle: TextStyle(
              fontSize: 12,
              color: Global.darkColor,
            ),
            selectedIconTheme: IconThemeData(
              size: 25,
              color: Global.darkColor,
            ),
            unselectedIconTheme: const IconThemeData(size: 20),
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo_rounded),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'My Uploads',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
