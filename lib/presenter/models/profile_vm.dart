class ProfileVM {
  String avatar;
  String name;
  String email;
  String? mobile;
  String? altPhone;
  String address;
  String vehicleInfo;
  String driverLicense;
  DateTime expiration;
  DateTime issueDate;

  ProfileVM(
      {required this.avatar,
      required this.name,
      required this.email,
      this.mobile,
      this.altPhone,
      required this.address,
      required this.vehicleInfo,
      required this.driverLicense,
      required this.expiration,
      required this.issueDate});
}
