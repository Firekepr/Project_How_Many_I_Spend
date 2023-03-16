class ConfigurationString {

  static const String configurations = 'Configurações';
  static const String Theme = 'Tema';

  static String calendarStyle(bool simple) {
    if (simple) {
      return 'Calendário: Simples';
    } else {
      return 'Calendário: Detalhado';
    }
  }
}