class ChangePasswordModel {
  String oldPassword;
  String newPassword;

  ChangePasswordModel.toJson(this.oldPassword, this.newPassword);
}
