class CreateTuanKiemModel {
  int? idDiaDiem;
  double? nhietDo;
  String? mucDoBui;
  double? doAm;
  String? danhGiaDoAm;
  String? khac;
  int? heThongLamMat;
  String? tinhTrangThietBi;
  int? emcDillters;
  int? lapDatTrongPhongDien;
  int? lichSuLoi;
  String? maLoi;
  int? ketLuan;
  String? thongTinKhac;
  String? noiDungKetLuan;
  String? deXuat;
  String? ktvTuanKiem;
  int? idUser;
  String? thoiGianKhoiTao;

  CreateTuanKiemModel({
    this.idDiaDiem,
    this.nhietDo,
    this.mucDoBui,
    this.doAm,
    this.danhGiaDoAm,
    this.khac,
    this.heThongLamMat,
    this.tinhTrangThietBi,
    this.emcDillters,
    this.lapDatTrongPhongDien,
    this.lichSuLoi,
    this.maLoi,
    this.ketLuan,
    this.noiDungKetLuan,
    this.deXuat,
    this.ktvTuanKiem,
    this.idUser,
    this.thongTinKhac,
    this.thoiGianKhoiTao,
  });

  // Method to convert the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'idDiaDiem': idDiaDiem,
      'nhietDo': nhietDo,
      'mucDoBui': mucDoBui,
      'doAm': doAm,
      'danhGiaDoAm': danhGiaDoAm,
      'khac': khac,
      'heThongLamMat': heThongLamMat,
      'tinhTrangThietBi': tinhTrangThietBi,
      'emcDillters': emcDillters,
      'lapDatTrongPhongDien': lapDatTrongPhongDien,
      'lichSuLoi': lichSuLoi,
      'maLoi': maLoi,
      'ketLuan': ketLuan,
      'thongTinKhac': thongTinKhac,
      'noiDungKetLuan': noiDungKetLuan,
      'deXuat': deXuat,
      'ktvTuanKiem': ktvTuanKiem, // Uncomment this if it's part of the model and should be included.
      'idUser': idUser,
      'thoiGianKhoiTao': thoiGianKhoiTao,
    };
  }
}
