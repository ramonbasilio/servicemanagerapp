import 'dart:convert';

class ReceiverDoc {
  String numberDoc;
  String equipment;
  String brand;
  String model;
  String accessories;
  String defect;
  List<String> pathImages;
  List<dynamic> pathSign;
  ReceiverDoc({
    required this.numberDoc,
    required this.equipment,
    required this.brand,
    required this.model,
    required this.accessories,
    required this.defect,
    required this.pathImages,
    required this.pathSign,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'numberRO': numberDoc});

    result.addAll({'equipment': equipment});
    result.addAll({'brand': brand});
    result.addAll({'model': model});
    result.addAll({'accessories': accessories});
    result.addAll({'defect': defect});
    result.addAll({'pathImages': pathImages});
    result.addAll({'pathSign': pathSign});

    return result;
  }

  factory ReceiverDoc.fromMap(Map<String, dynamic> map) {
    return ReceiverDoc(
      numberDoc: map['numberRO'],
      equipment: map['equipment'],
      brand: map['brand'],
      model: map['model'],
      accessories: map['accessories'],
      defect: map['defect'],
      pathImages: List<String>.from(map['pathImages']),
      pathSign: map['pathSign'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceiverDoc.fromJson(String source) =>
      ReceiverDoc.fromMap(json.decode(source));
}