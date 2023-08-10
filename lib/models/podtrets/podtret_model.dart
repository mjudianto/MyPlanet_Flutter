// To parse this JSON data, do
//
//     final podtret = podtretFromJson(jsonString);

import 'dart:convert';

Podtret podtretFromJson(String str) => Podtret.fromJson(json.decode(str));

String podtretToJson(Podtret data) => json.encode(data.toJson());

class Podtret {
    String? message;
    List<Datum>? data;

    Podtret({
        this.message,
        this.data,
    });

    factory Podtret.fromJson(Map<String, dynamic> json) => Podtret(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? podtretId;
    int? podtretKategoriId;
    String? judul;
    String? thumbnail;
    String? video;
    String? audio;
    int? views;
    String? uploadDate;
    int? state;
    String? publishDate;
    String? nama;

    Datum({
        this.podtretId,
        this.podtretKategoriId,
        this.judul,
        this.thumbnail,
        this.video,
        this.audio,
        this.views,
        this.uploadDate,
        this.state,
        this.publishDate,
        this.nama,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        podtretId: json["podtretId"],
        podtretKategoriId: json["podtretKategoriId"],
        judul: json["judul"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        audio: json["audio"],
        views: json["views"],
        uploadDate: json["uploadDate"],
        state: json["state"],
        publishDate: json["publishDate"],
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "podtretId": podtretId,
        "podtretKategoriId": podtretKategoriId,
        "judul": judul,
        "thumbnail": thumbnail,
        "video": video,
        "audio": audio,
        "views": views,
        "uploadDate": uploadDate,
        "state": state,
        "publishDate": publishDate,
        "nama": nama,
    };
}
