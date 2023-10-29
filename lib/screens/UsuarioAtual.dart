class UsuarioAtual {
  static final UsuarioAtual _singleton = UsuarioAtual._internal();

  factory UsuarioAtual() {
    return _singleton;
  }

  UsuarioAtual._internal();

  int? userId;
}