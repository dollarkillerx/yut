import 'dart:convert';
import 'package:flutter/widgets.dart';


Image imageFromBase64String(String base64String) {
  return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
  );
}
