import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  String menuName = '';
  final IconData menuIcon;
  MenuItem({Key? key, required this.menuName, required this.menuIcon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children:  [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Icon(
              menuIcon,
              color: Color(0xFF344fa1),
            ),
          ),
          Text(
            menuName,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15
            ),
          )
        ],
      ),
    );
  }
}