import 'package:flutter/material.dart';
import 'package:todotoday/objects/tasks.dart';

const kAccentColor = Color(0xFF63c9fe);
const kYellowSunriseColor = Color(0xFFFFF5BD);
const kBodyColor = Colors.white;
const kIconSize = 40.0;
const kTitleSize = 46.0;
const kCardTitle = 25.0;
const kIconPadding = EdgeInsets.all(10.0);
const kFontFamily = TextStyle(fontFamily: 'ABeeZee', fontSize: 18);
const kCardRadius = BorderRadius.vertical(top: Radius.circular(30));
const kCardPadding = EdgeInsets.all(40.0);
const kItemListPadding = EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0);
const kButtonRadius = BorderRadius.all(Radius.circular(20));
const kButtonPadding = EdgeInsets.all(20);
const kSunriseGradient = LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [kYellowSunriseColor, kAccentColor]);