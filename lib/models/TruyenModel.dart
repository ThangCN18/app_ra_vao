import 'package:ra_soat_ra_vao/models/dropdown_value_model.dart';
import 'package:ra_soat_ra_vao/models/user_model.dart';

class TruyenModel {
  final String? id;
  final List<DropdownValue>? listYeuCau;
  final User? user;

  TruyenModel({this.id, this.listYeuCau, this.user});

  // Convert the model to a map for serialization (must be serializable for restoration)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'listYeuCau': listYeuCau?.map((e) => e.toMap()).toList(),
      'user': user?.toMap(), // Add user to the map
    };
  }

  // Convert the map back to TruyenModel for deserialization
  static TruyenModel fromMap(Map<String, dynamic> map) {
    return TruyenModel(
      id: map['id'],
      listYeuCau: map['listYeuCau'] != null
          ? List<DropdownValue>.from(map['listYeuCau'].map((x) => DropdownValue.fromMap(x)))
          : null,
      user: map['user'] != null ? User.fromMap(map['user']) : null, // Handle user deserialization
    );
  }
}
