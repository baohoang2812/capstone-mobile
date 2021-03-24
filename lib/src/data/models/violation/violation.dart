import 'package:equatable/equatable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Violation extends Equatable {
  final int id;
  final String name;
  final String status;
  final String violationCode;
  final DateTime createdAt;
  String imagePath;
  final String description;
  final int regulationId;
  final String regulationName;
  int branchId;
  final branchName;
  List<String> imagePaths;
  List<Asset> assets;
  final String excuse;

  Violation({
    this.id,
    this.name,
    this.status,
    this.violationCode,
    this.createdAt,
    this.imagePath,
    this.description,
    this.regulationId,
    this.regulationName,
    this.branchId,
    this.branchName,
    this.imagePaths,
    this.assets,
    this.excuse,
  });

  @override
  List<Object> get props => [
        id,
        name,
        status,
        violationCode,
        createdAt,
        imagePath,
        description,
        regulationId,
        regulationName,
        branchId,
        branchName,
        imagePaths,
        assets,
        excuse,
      ];

  static Violation fromJson(dynamic json) {
    return Violation(
      id: json['id'],
      name: json['name'],
      branchId: json['branch']['id'],
      branchName: json['branch']['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      regulationId: json['regulation']['id'],
      regulationName: json['regulation']['name'],
      excuse: json['excuse'],
      imagePaths:
          List<String>.from(json['evidence'].map((e) => e['imagePath'])),
    );
  }

  Violation copyWith({
    DateTime createdAt,
    int id,
    String name,
    String imagePath,
    String description,
    int regulationId,
    String regulationName,
    int branchId,
    String branchName,
    String status,
    List<String> imagePaths,
    List<Asset> assets,
    String excuse,
  }) {
    return Violation(
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      createdAt: this.createdAt,
      description: description ?? this.description,
      id: this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      regulationId: regulationId ?? this.regulationId,
      regulationName: regulationName ?? this.regulationName,
      status: status ?? this.status,
      violationCode: this.violationCode,
      imagePaths: imagePaths ?? this.imagePaths,
      assets: assets ?? this.assets,
      excuse: excuse ?? this.excuse,
    );
  }

  static List<Map<String, dynamic>> convertListViolationToListMap(
      List<Violation> violations) {
    List<Map<String, dynamic>> list = List();

    violations.forEach((violation) {
      list.add(<String, dynamic>{
        'name': 'name',
        'description': violation.description.trim(),
        'imagePath': violation.imagePath,
        'regulationId': violation.regulationId,
        'branchId': violation.branchId,
        'excuse': violation.excuse,
        'evidenceCreate': [
          ...violation.imagePaths.map((imagePath) => {"imagePath": imagePath})
        ]
      });
    });

    return list;
  }
}
