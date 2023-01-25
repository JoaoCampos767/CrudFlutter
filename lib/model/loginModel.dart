// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  String? _email;
  String? _senha;

  LoginModel(this._email, this._senha);

  get email => this._email;

  set email(value) => this._email = value;

  get senha => this._senha;

  set senha(value) => this._senha = value;
}
