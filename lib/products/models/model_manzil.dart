// To parse this JSON data, do
//
//     final modelPost = modelPostFromMap(jsonString);

import 'dart:convert';

ManzilModel modelPostFromMap(String str) => ManzilModel.fromMap(json.decode(str));

String modelPostToMap(ManzilModel data) => json.encode(data.toMap());

class ManzilModel {
  int? code;
  String? status;
  Data? data;

  ManzilModel({
    this.code,
    this.status,
    this.data,
  });

  factory ManzilModel.fromMap(Map<String, dynamic> json) => ManzilModel(
    code: json["code"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "status": status,
    "data": data?.toMap(),
  };
}

class Data {
  int? number;
  List<Ayah>? ayahs;
  Map<String, Surah>? surahs;
  Edition? edition;

  Data({
    this.number,
    this.ayahs,
    this.surahs,
    this.edition,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    number: json["number"],
    ayahs: json["ayahs"] == null ? [] : List<Ayah>.from(json["ayahs"]!.map((x) => Ayah.fromMap(x))),
    surahs: Map.from(json["surahs"]!).map((k, v) => MapEntry<String, Surah>(k, Surah.fromMap(v))),
    edition: json["edition"] == null ? null : Edition.fromMap(json["edition"]),
  );

  Map<String, dynamic> toMap() => {
    "number": number,
    "ayahs": ayahs == null ? [] : List<dynamic>.from(ayahs!.map((x) => x.toMap())),
    "surahs": Map.from(surahs!).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
    "edition": edition?.toMap(),
  };
}

class Ayah {
  int? number;
  String? text;
  Surah? surah;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  dynamic sajda;

  Ayah({
    this.number,
    this.text,
    this.surah,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory Ayah.fromMap(Map<String, dynamic> json) => Ayah(
    number: json["number"],
    text: json["text"],
    surah: json["surah"] == null ? null : Surah.fromMap(json["surah"]),
    numberInSurah: json["numberInSurah"],
    juz: json["juz"],
    manzil: json["manzil"],
    page: json["page"],
    ruku: json["ruku"],
    hizbQuarter: json["hizbQuarter"],
    sajda: json["sajda"],
  );

  Map<String, dynamic> toMap() => {
    "number": number,
    "text": text,
    "surah": surah?.toMap(),
    "numberInSurah": numberInSurah,
    "juz": juz,
    "manzil": manzil,
    "page": page,
    "ruku": ruku,
    "hizbQuarter": hizbQuarter,
    "sajda": sajda,
  };
}

class SajdaClass {
  int? id;
  bool? recommended;
  bool? obligatory;

  SajdaClass({
    this.id,
    this.recommended,
    this.obligatory,
  });

  factory SajdaClass.fromMap(Map<String, dynamic> json) => SajdaClass(
    id: json["id"],
    recommended: json["recommended"],
    obligatory: json["obligatory"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "recommended": recommended,
    "obligatory": obligatory,
  };
}

class Surah {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  int? numberOfAyahs;

  Surah({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.numberOfAyahs,
  });

  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
    number: json["number"],
    name: json["name"],
    englishName: json["englishName"],
    englishNameTranslation: json["englishNameTranslation"],
    revelationType: json["revelationType"],
    numberOfAyahs: json["numberOfAyahs"],
  );

  Map<String, dynamic> toMap() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "revelationType": revelationType,
    "numberOfAyahs": numberOfAyahs,
  };
}

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;
  String? direction;

  Edition({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
    this.direction,
  });

  factory Edition.fromMap(Map<String, dynamic> json) => Edition(
    identifier: json["identifier"],
    language: json["language"],
    name: json["name"],
    englishName: json["englishName"],
    format: json["format"],
    type: json["type"],
    direction: json["direction"],
  );

  Map<String, dynamic> toMap() => {
    "identifier": identifier,
    "language": language,
    "name": name,
    "englishName": englishName,
    "format": format,
    "type": type,
    "direction": direction,
  };
}
