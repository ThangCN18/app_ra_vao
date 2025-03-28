class CreateHieuChinhModel {
  int? idChuyenHang;
  int? idCong;
  int? idKho;
  int? idNguoiDung;
  int? idNoiDung;
  String? maNvThucTe;
  String? noiDung;
  String? thoiGianYeuCau;
  int? idKeHoach;

  CreateHieuChinhModel({
    this.idChuyenHang,
    this.idCong,
    this.idKho,
    this.idNguoiDung,
    this.idNoiDung,
    this.thoiGianYeuCau,
    this.noiDung,
    this.maNvThucTe,
    this.idKeHoach,
  });

  Map<String, dynamic> toJson() {
    return {
      'idChuyenHang': idChuyenHang,
      'idKeHoach': idKeHoach,
      'idNguoiDung': idNguoiDung,
      'idCong': idCong,
      'idKho': idKho,
      'idNoiDung': idNoiDung,
      'maNvThucTe': maNvThucTe,
      'noiDung': noiDung,
      'thoiGianYeuCau': thoiGianYeuCau,
    };
  }

}