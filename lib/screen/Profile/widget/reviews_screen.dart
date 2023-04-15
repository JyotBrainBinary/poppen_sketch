import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30,),
        Text("Review",textAlign: TextAlign.center,style: TextStyle(
            fontSize: 25,fontWeight:FontWeight.w600),),
      ],
    );
  }
}
