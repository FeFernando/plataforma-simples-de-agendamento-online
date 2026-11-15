
import 'package:flutter_test/flutter_test.dart';
import 'package:plataforma_agendamento/validators/agendamento_validator.dart';

void main() {
  group('Validação do nome', () {
    test('deve rejeitar nome vazio', () {
      expect(
        AgendamentoValidator.validarNome('   '),
        'Informe o nome do cliente.',
      );
    });

    test('deve aceitar nome válido', () {
      expect(
        AgendamentoValidator.validarNome('Felipe'),
        isNull,
      );
    });
  });

  group('Validação do telefone', () {
    test('deve rejeitar telefone vazio', () {
      expect(
        AgendamentoValidator.validarTelefone(''),
        'Informe o telefone.',
      );
    });

    test('deve aceitar telefone com DDD', () {
      expect(
        AgendamentoValidator.validarTelefone('(17) 99999-9999'),
        isNull,
      );
    });

    test('deve rejeitar telefone inválido', () {
      expect(
        AgendamentoValidator.validarTelefone('12345'),
        'Informe um telefone válido com DDD.',
      );
    });
  });
}
