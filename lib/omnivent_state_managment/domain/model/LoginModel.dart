class LoginModel {

  
  String _usuario = '';
  String _password = '';

  get usuario => this._usuario;

  set usuario(String usuario){
    this._usuario = usuario;
  }

  get password => this._password;

  set password(String password){
    this._password = password;
  }

}