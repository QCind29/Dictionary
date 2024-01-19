import 'dart:convert';


List<Wiki> WikiFromJson(String str) => List<Wiki>.from(json.decode(str).map((x)=>Wiki.fromJson(x)));

String WikiToJson(List<Wiki> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Wiki {
    String id;
    String detail;
 

    Wiki({
        required this.id,
        required this.detail,
      
    });

    factory Wiki.fromJson(Map<String, dynamic> json) => Wiki(
        id: json['id']??'',
        detail: json['detail']??'',
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": detail,
       
    };

}
