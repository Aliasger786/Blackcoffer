import 'package:flutter/material.dart';

import '../../Global/global.dart';

class DisplayAppBar extends StatelessWidget {
  const DisplayAppBar({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 60,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
            margin: const EdgeInsets.only(left: 14, top: 10, bottom: 10),
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow:Global.neuShadowsCircularDark,

              color:Global.darkColor

            ),
            child: Icon(
              Icons.arrow_back,
              color:  Global.darkColor,
            )),
      ),
      title: Text(
        "About this post",
        style: TextStyle(
          color: Global.darkColor,
          fontSize: 28,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
              margin: const EdgeInsets.only(
                  left: 14, top: 10, bottom: 10, right: 14),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: Global.neuShadowsCircularDark,

                color:Global.darkColor

              ),
              child: Icon(
                Icons.notifications,
                color: Global.darkColor,
              )),
        ),
      ],
    );
  }
}
