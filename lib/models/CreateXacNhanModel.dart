class CreateXacNhanModel {
  int? idChuyenHang;
  int? idNhanVienXacNhan;
  int? loaiXacNhan;
  String? nhanVienXacNhan;
  String? ghiChu;
  String? thoiGianXacNhan;
  int? idCong;
  int? idKho;

  CreateXacNhanModel({
    this.idChuyenHang,
    this.idNhanVienXacNhan,
    this.loaiXacNhan,
    this.nhanVienXacNhan,
    this.ghiChu,
    this.thoiGianXacNhan,
    this.idCong,
    this.idKho,
  });

  Map<String, dynamic> toJson() {
    return {
      'idChuyenHang': idChuyenHang,
      'idNhanVienXacNhan': idNhanVienXacNhan,
      'loaiXacNhan': loaiXacNhan,
      'nhanVienXacNhan': nhanVienXacNhan,
      'ghiChu': ghiChu,
      'thoiGianXacNhan': thoiGianXacNhan,
      'idCong': idCong,
      'idKho': idKho,
    };
  }
}