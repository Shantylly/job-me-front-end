import 'package:flutter/material.dart';

//Function "StarDisplay" is use to display the number of star depending of the review a company or a jobbeur
//Got from previous reviews. Min value = 0 and max value = 5.

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}
