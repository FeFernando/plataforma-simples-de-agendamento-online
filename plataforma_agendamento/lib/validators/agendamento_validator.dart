
class AgendamentoValidator {
  static String? validarNome(String nome) {
    final nomeTratado = nome.trim();

    if (nomeTratado.isEmpty) {
      return 'Informe o nome do cliente.';
    }

    if (nomeTratado.length < 2) {
      return 'O nome deve ter pelo menos 2 caracteres.';
    }

    return null;
  }

  static String? validarTelefone(String telefone) {
    final numeros = telefone.replaceAll(RegExp(r'\D'), '');

    if (numeros.isEmpty) {
      return 'Informe o telefone.';
    }

    if (numeros.length < 10 || numeros.length > 11) {
      return 'Informe um telefone válido com DDD.';
    }

    return null;
  }
}
