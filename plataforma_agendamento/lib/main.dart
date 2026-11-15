
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plataforma de Agendamento',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B55),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
        fontFamily: 'Roboto',
      ),
      home: const AgendamentoPage(),
    );
  }
}

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  bool _altoContraste = false;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();

  final List<String> _horarios = [
    '09:00',
    '10:00',
    '11:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  String? _horarioSelecionado;
  final Set<String> _horariosOcupados = {};

  void _confirmarAgendamento() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_horarioSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um horário disponível.'),
        ),
      );
      return;
    }

    setState(() {
      _horariosOcupados.add(_horarioSelecionado!);
    });

    final nome = _nomeController.text.trim();
    final horario = _horarioSelecionado!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Color(0xFF176B55),
          size: 48,
        ),
        title: const Text('Agendamento confirmado!'),
        content: Text(
          '$nome, seu horário foi reservado para as $horario.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );

    _formKey.currentState!.reset();
    _nomeController.clear();
    _telefoneController.clear();

    setState(() {
      _horarioSelecionado = null;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _altoContraste
    ? Colors.black
    : const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: _altoContraste
            ? Colors.black
            : const Color(0xFF176B55),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: _altoContraste
                ? 'Desativar alto contraste'
                : 'Ativar alto contraste',
            onPressed: () {
              setState(() {
                _altoContraste = !_altoContraste;
              });
            },
            icon: const Icon(Icons.contrast),
          ),
        ],
        title: const Row(
          children: [
            Icon(Icons.content_cut, size: 23),
            SizedBox(width: 10),
            Text(
              'AGENDAMENTO ONLINE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Barbearia',
                    style: TextStyle(
                      color: _altoContraste
                          ? Colors.yellow
                          : const Color(0xFF176B55),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                      'Agende seu horário',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: _altoContraste
                            ? Colors.white
                            : const Color(0xFF202B27),
                      ),
                    ),
                const SizedBox(height: 8),
                Text(
                  'Preencha seus dados e escolha um horário disponível.',
                  style: TextStyle(
                    fontSize: 15,
                    color: _altoContraste
                        ? Colors.white
                        : const Color(0xFF52615B),
                  ),
                ),
                const SizedBox(height: 26),

                Card(
                  elevation: 0,
                  color: _altoContraste
                  ? const Color(0xFF1A1A1A)
                  : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                          color: _altoContraste ? Colors.white : const Color(0xFFE1E8E4),
                          width: _altoContraste ? 2 : 1,
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seus dados',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: _altoContraste ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 18),

                          TextFormField(
                            controller: _nomeController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'Nome completo',
                              hintText: 'Digite seu nome',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Informe seu nome.';
                              }
                              if (value.trim().length < 2) {
                                return 'Digite pelo menos 2 caracteres.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _telefoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Telefone',
                              hintText: '(00) 00000-0000',
                              prefixIcon: Icon(Icons.phone_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              final numeros = (value ?? '')
                                  .replaceAll(RegExp(r'\D'), '');

                              if (numeros.isEmpty) {
                                return 'Informe seu telefone.';
                              }
                              if (numeros.length < 10 ||
                                  numeros.length > 11) {
                                return 'Informe um telefone válido com DDD.';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 28),
                          Text(
                            'Escolha um horário',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: _altoContraste ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Horários disponíveis para atendimento',
                            style: TextStyle(
                              color: _altoContraste ? Colors.white : const Color(0xFF52615B),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _horarios.map((horario) {
                              final ocupado =
                                  _horariosOcupados.contains(horario);
                              final selecionado =
                                  _horarioSelecionado == horario;

                              return ChoiceChip(
                                label: Text(horario),
                                selected: selecionado,
                                onSelected: ocupado
                                    ? null
                                    : (selected) {
                                        setState(() {
                                          _horarioSelecionado =
                                              selected ? horario : null;
                                        });
                                      },
                                selectedColor: _altoContraste
                                    ? Colors.yellow
                                    : const Color(0xFF176B55),
                                backgroundColor: _altoContraste
                                    ? const Color(0xFF333333)
                                    : null,
                                labelStyle: TextStyle(
                                  color: _altoContraste
                                      ? (selecionado ? Colors.black : Colors.white)
                                      : selecionado
                                          ? Colors.white
                                          : ocupado
                                              ? Colors.grey
                                              : const Color(0xFF26352E),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 26),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: FilledButton.icon(
                              onPressed: _confirmarAgendamento,
                              icon: const Icon(Icons.calendar_month),
                              label: const Text(
                                'Confirmar agendamento',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF176B55),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),
                const Center(
                  child: Text(
                    'Plataforma de Agendamento Online',
                    style: TextStyle(
                      color: Color(0xFF65736D),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
