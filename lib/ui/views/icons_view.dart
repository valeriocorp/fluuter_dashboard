import 'package:dashboard/ui/cards/white_card.dart';
import 'package:dashboard/ui/labels/custom_label.dart';
import 'package:flutter/material.dart';

class IconsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Icons",
            style: CustomLabel.h1,
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              WhiteCard(
                width: 170,
                title: 'ac_unit_outlined',
                child: Center(
                  child: Icon(Icons.ac_unit_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: 'access_alarm_outlined',
                child: Center(
                  child: Icon(Icons.access_alarm_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: 'access_alarms_outlined',
                child: Center(
                  child: Icon(Icons.access_alarms_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: 'access_time_filled_outlined',
                child: Center(
                  child: Icon(Icons.access_time_filled_outlined),
                ),
              ),
              WhiteCard(
                width: 170,
                title: 'accessibility_new_outlined',
                child: Center(
                  child: Icon(Icons.accessibility_new_outlined),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
