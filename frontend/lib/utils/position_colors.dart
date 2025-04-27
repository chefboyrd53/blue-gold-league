import 'package:flutter/material.dart';

Color getPositionColor(String position) {
  switch (position) {
    case 'QB':
      return Colors.redAccent;
    case 'RB':
      return Colors.greenAccent;
    case 'WR':
      return Colors.lightBlueAccent;
    case 'TE':
      return Colors.orangeAccent;
    case 'K':
      return Colors.purpleAccent;
    case 'DST':
      return Colors.indigoAccent;
    default:
      return Colors.grey;
  }
}
