import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 69,
      padding: EdgeInsets.only(top: 26, bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: Color(0x4cffffff),
        ),
        gradient: LinearGradient(colors: [
          Color(0x4ca6a1e0),
          Color(0x4ca1f3fe),
        ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(image),
          Text(
            title,
            style: TextStyle(
              fontSize: 9,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    );
  }
}
