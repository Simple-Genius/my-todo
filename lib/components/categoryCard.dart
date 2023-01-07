import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final int numberOfTasks;
  late var categoryName;
  late VoidCallback onPressed;
  late VoidCallback onEditButtonPressed;

  CategoryCard({Key? key, required this.categoryName, required this.numberOfTasks, required this.onPressed, required this.onEditButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left : 10.0),
      child: Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: 200,
          height: 80,
          decoration: BoxDecoration(
              color: const Color(0xFF031A55),
              borderRadius: BorderRadius.circular(14)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$numberOfTasks Tasks',

                style: const TextStyle(
                  color: Color(0xff697bad),
                  decoration: TextDecoration.none,
                  fontSize: 13,
                ),
              ),
              Text(
                categoryName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    decoration: TextDecoration.none
                ),
              ),

              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      onPressed: onEditButtonPressed,
                      icon: const Icon(Icons.edit, color: Colors.white,),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Icons.delete, color: Colors.white,),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
