import 'package:chat_app/constans.dart';

class Massage {
  final String massages;
  final String id;

  Massage(this.massages, this.id);

  factory Massage.fromJson(jsonData) {
    return Massage(jsonData[KmassageCollection], jsonData[Kid]);
  }
}
