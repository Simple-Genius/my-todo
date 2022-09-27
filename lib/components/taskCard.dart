import 'package:flutter/material.dart';


class TaskCard extends StatelessWidget {


  final bool newValue;
  final String taskName;
  var onTap;
  var onDeleteButtonPressed;
  var onEditButtonPressed;

  TaskCard({Key? key,
    required this.onTap,
    required this.newValue,
    required this.taskName,
    required this.onDeleteButtonPressed,
    required this.onEditButtonPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF031A55),
            borderRadius: BorderRadius.circular(10)
        ),
        width: 360,
        height: 55,
        child: Row(
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.purpleAccent),
              child: Checkbox(
                  shape: const CircleBorder(),
                  value: newValue,
                  onChanged: onTap,
              ),
            ),
             Expanded(
               child: Text(
                taskName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                     color: Colors.white,
                    fontSize: 15
                ),
            ),
             ),

            IconButton(
              onPressed: onEditButtonPressed,
              icon: const Icon(Icons.edit, color: Colors.white),
            ),
            IconButton(
              onPressed: onDeleteButtonPressed,
              icon: const Icon(Icons.delete, color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}




