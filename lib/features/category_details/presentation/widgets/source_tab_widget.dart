import 'package:flutter/material.dart';

import '../../data/models/sources/Sources.dart';

class TabWidget extends StatelessWidget {
  Source source;
  bool isSelected;
  TabWidget(this.source , this.isSelected , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text = source.name;
    double textWidth = getTextWidth(text, const TextStyle(fontSize: 14, fontWeight: FontWeight.w500));
    return SizedBox(
      height: 60,
      child :Container(
        margin: const EdgeInsets.all(5),
        width: textWidth + 40,
        height: 45,
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xff39A552) : Colors.white54,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: const Color(0xff39A552),
                width: 2
            )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              text??"",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double getTextWidth(String? text, TextStyle textStyle) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.width;
  }
}
