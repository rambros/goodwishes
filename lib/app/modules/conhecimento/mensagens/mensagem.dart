class Mensagem {
  final int? id;
  final String? tema;
  final String? mensagem;

  Mensagem({this.id, this.tema, this.mensagem});

  factory Mensagem.fromJson(Map<String, dynamic> json) {
    return Mensagem(
      id: json['id'] as int?,
      tema: json['t'] as String?,
      mensagem: json['m'] as String?,
    );
  }
}