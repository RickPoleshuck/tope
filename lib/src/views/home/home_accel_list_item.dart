import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tope/src/utils/vector.dart';

class HomeAccelListItem extends ListTile {
  static final DateFormat hhmmss = DateFormat('HH:mm:ss');

  HomeAccelListItem(Vector v, {super.key})
      : super(
            title: Text('${hhmmss.format(DateTime.now())}: ${v.display()}',
                style: const TextStyle(fontSize: 20)));
}
