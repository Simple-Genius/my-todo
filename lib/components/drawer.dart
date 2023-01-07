import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';

import '../TodoScreen.dart';
import 'menuItem.dart';

class myDrawer extends StatelessWidget {
   myDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF031A55),
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0, left: 50),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(color: const Color(0xFF344fa1))
            //     ),
            //     child: IconButton(
            //         onPressed: (){
            //
            //         },
            //         icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white,)
            //     ),
            //   ),
            // ),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/pexels-liam-anderson-1458332.jpg',
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 5.0),
              child: Text(
                'Micheala',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white
                ),
              ),
            ),
            const Text(
              'Daniels',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    MenuItem(menuIcon: Icons.bookmark_outline, menuName: 'Templates'),
                    MenuItem(menuName: 'Categories', menuIcon: MfgLabs.th_thumb_empty),
                    MenuItem(menuName: 'Analytics', menuIcon: Entypo.chart_pie)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
