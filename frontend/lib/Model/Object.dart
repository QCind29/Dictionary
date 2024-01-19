import 'dart:convert';


List<Object> ObjectFromJson(String str) => List<Object>.from(json.decode(str).map((x)=>Object.fromJson(x)));

String ObjectToJson(List<Object> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Object {
    String id;
    String label;
    String name;
    String img;

    Object({
        required this.id,
        required this.label,
        required this.img,
        required this.name
    });

    factory Object.fromJson(Map<String, dynamic> json) => Object(
        id: json['id']??'',
        label: json['label']??'',
        name: json['object'] ?? '',
        img: json['image']?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "object": name,
        "image": img,
    };

}
