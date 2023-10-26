// To parse this JSON data, do
//
//     final podtretComment = podtretCommentFromJson(jsonString);

import 'dart:convert';

PodtretComment podtretCommentFromJson(String str) => PodtretComment.fromJson(json.decode(str));

String podtretCommentToJson(PodtretComment data) => json.encode(data.toJson());

class PodtretComment {
    String? message;
    List<PodtretCommentElement>? podtretComment;

    PodtretComment({
        this.message,
        this.podtretComment,
    });

    factory PodtretComment.fromJson(Map<String, dynamic> json) => PodtretComment(
        message: json["message"],
        podtretComment: json["podtretComment"] == null ? [] : List<PodtretCommentElement>.from(json["podtretComment"]!.map((x) => PodtretCommentElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "podtretComment": podtretComment == null ? [] : List<dynamic>.from(podtretComment!.map((x) => x.toJson())),
    };
}

class PodtretCommentElement {
    int? podtretCommentId;
    int? podtretId;
    String? userNik;
    String? comment;
    DateTime? uploadDate;
    String? nama;
    List<Reply>? reply;

    PodtretCommentElement({
        this.podtretCommentId,
        this.podtretId,
        this.userNik,
        this.comment,
        this.uploadDate,
        this.nama,
        this.reply,
    });

    factory PodtretCommentElement.fromJson(Map<String, dynamic> json) => PodtretCommentElement(
        podtretCommentId: json["podtretCommentId"],
        podtretId: json["podtretId"],
        userNik: json["userNik"],
        comment: json["comment"],
        uploadDate: json["uploadDate"] == null ? null : DateTime.parse(json["uploadDate"]),
        nama: json["nama"],
        reply: json["reply"] == null ? [] : List<Reply>.from(json["reply"]!.map((x) => Reply.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "podtretCommentId": podtretCommentId,
        "podtretId": podtretId,
        "userNik": userNik,
        "comment": comment,
        "uploadDate": uploadDate?.toIso8601String(),
        "nama": nama,
        "reply": reply == null ? [] : List<dynamic>.from(reply!.map((x) => x.toJson())),
    };
}

class Reply {
    int? commentReplyId;
    int? podtretCommentId;
    String? userNik;
    String? comment;
    DateTime? uploadDate;
    String? nama;

    Reply({
        this.commentReplyId,
        this.podtretCommentId,
        this.userNik,
        this.comment,
        this.uploadDate,
        this.nama,
    });

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        commentReplyId: json["commentReplyId"],
        podtretCommentId: json["podtretCommentId"],
        userNik: json["userNik"],
        comment: json["comment"],
        uploadDate: json["uploadDate"] == null ? null : DateTime.parse(json["uploadDate"]),
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "commentReplyId": commentReplyId,
        "podtretCommentId": podtretCommentId,
        "userNik": userNik,
        "comment": comment,
        "uploadDate": uploadDate?.toIso8601String(),
        "nama": nama,
    };
}
