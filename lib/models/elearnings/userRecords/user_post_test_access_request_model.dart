// To parse this JSON data, do
//
//     final userPostTestAccessRequest = userPostTestAccessRequestFromJson(jsonString);

import 'dart:convert';

UserPostTestAccessRequest userPostTestAccessRequestFromJson(String str) => UserPostTestAccessRequest.fromJson(json.decode(str));

String userPostTestAccessRequestToJson(UserPostTestAccessRequest data) => json.encode(data.toJson());

class UserPostTestAccessRequest {
    String? message;
    Data? data;

    UserPostTestAccessRequest({
        this.message,
        this.data,
    });

    factory UserPostTestAccessRequest.fromJson(Map<String, dynamic> json) => UserPostTestAccessRequest(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? userRequestId;
    int? userTestRecordId;
    String? message;
    int? adminReply;
    dynamic punishment;
    dynamic adminReplyMessage;

    Data({
        this.userRequestId,
        this.userTestRecordId,
        this.message,
        this.adminReply,
        this.punishment,
        this.adminReplyMessage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userRequestId: json["userRequestId"],
        userTestRecordId: json["userTestRecordId"],
        message: json["message"],
        adminReply: json["adminReply"],
        punishment: json["punishment"],
        adminReplyMessage: json["adminReplyMessage"],
    );

    Map<String, dynamic> toJson() => {
        "userRequestId": userRequestId,
        "userTestRecordId": userTestRecordId,
        "message": message,
        "adminReply": adminReply,
        "punishment": punishment,
        "adminReplyMessage": adminReplyMessage,
    };
}
