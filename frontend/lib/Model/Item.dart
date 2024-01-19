import 'dart:convert';


List<Item> ItemFromJson(String str) => List<Item>.from(json.decode(str).map((x)=>Item.fromJson(x)));

String ItemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Item {
    String id;
    String label;
    String name;
    String img;

    Item({
        required this.id,
        required this.label,
        required this.img,
        required this.name
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id']??'',
        label: json['label']??'',
        name: json['Item'] ?? '',
        img: json['image']?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "Item": name,
        "image": img,
    };

}
