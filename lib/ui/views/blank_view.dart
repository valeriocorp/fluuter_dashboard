import 'package:dashboard/ui/cards/white_card.dart';
import 'package:dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';

class BlankView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Blank View",
            style: CustomLabel.h1,
          ),
          SizedBox(
            height: 10,
          ),
          WhiteCard(
            title: 'Sales statistics',
            child: Text('Pantalla en blanco'),
          ),
        ],
      ),
    );
  }
}
