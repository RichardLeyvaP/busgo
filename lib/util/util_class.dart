import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationManager {
  static late Locale _locale;
  static Map<String, dynamic> _localizedValues = {};

  static List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('pt', 'BR'),
  ];

  static LocalizationsDelegate<TranslationManager> delegate = const _TranslationDelegate();

  // Cargar las traducciones por defecto al iniciar la aplicación
  static Future<void> loadDefaultTranslations(String locale) async {
    _locale = getCurrentApi(locale);
    await loadTranslations(_locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', locale);
  }

  // Cargar traducciones específicas para un locale dado
  static Future<void> loadTranslations(Locale locale) async {
    try {
      // Cargar contenido del archivo .arb correspondiente
      String jsonContent = await rootBundle.loadString('lib/l10n/app_${locale.languageCode}.arb');
      _localizedValues = json.decode(jsonContent);
    } catch (e) {
      print("Error loading translations: $e");
      _localizedValues = {}; // Asignar un mapa vacío en caso de error
    }
    _locale = locale;
  }

  // Método para traducir una clave dada
  static String translate(String key) {
    return _localizedValues[key] ?? key; // Si la clave no existe, retorna la clave misma
  }

  // Obtener el locale actual
  static Locale getCurrentLocale() {
    return _locale;
  }

  // Obtener el locale actual según el idioma proporcionado
  static Locale getCurrentApi(String idioma) {
    switch (idioma) {
      case "es":
        return const Locale('es', 'ES');
      case "en":
        return const Locale('en', 'US');
      case "pt":
        return const Locale('pt', 'BR');
      default:
        return const Locale('es', 'ES'); // Valor por defecto
    }
  }

  // Actualizar el locale actual
  static void updateLocale(Locale locale) {
    _locale = locale;
  }

  // Método para encontrar el locale del sistema operativo (puede ser asíncrono)
  static Future<Locale> findSystemLocale() async {
    // Implementa aquí la lógica para determinar el idioma del sistema operativo
    return const Locale('es', 'ES'); // Valor por defecto
  }
}

class _TranslationDelegate extends LocalizationsDelegate<TranslationManager> {
  const _TranslationDelegate();

  @override
  bool isSupported(Locale locale) => TranslationManager.supportedLocales.contains(locale);

  @override
  Future<TranslationManager> load(Locale locale) async {
    await TranslationManager.loadTranslations(locale);
    return TranslationManager();
  }

  @override
  bool shouldReload(_TranslationDelegate old) => false;
}

//
//
//
/*
class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'English'; // Valor inicial seleccionado

  List<String> _languages = ['English', 'Español', 'Português']; // Lista de idiomas

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguage,
      items: _languages.map((String language) {
        return DropdownMenuItem<String>(
          value: language,
          child: Text(language),
        );
      }).toList(),
      onChanged: (String? selectedLanguage) {
        if (selectedLanguage != null) {
          setState(() {
            _selectedLanguage = selectedLanguage;
          });

          // Cambia el idioma en la aplicación
          Locale newLocale;
          switch (selectedLanguage) {
            case 'English':
              newLocale = const Locale('en', 'US');
              break;
            case 'Español':
              newLocale = const Locale('es', 'ES');
              break;
            case 'Português':
              newLocale = const Locale('pt', 'BR');
              break;
            default:
              newLocale = const Locale('en', 'US'); // Idioma por defecto
          }

          // Actualiza el locale y las traducciones
          TranslationManager.loadTranslations(newLocale).then((_) {
            TranslationManager.updateLocale(newLocale);
            setState(() {
              // Puedes agregar cualquier actualización adicional aquí
            });
          });
        }
      },
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
    );
  }
}*/

class Language {
  final String name;
  final String code;
  final IconData icon;

  Language({
    required this.name,
    required this.code,
    required this.icon,
  });
}

class LanguageSelectorNew extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  LanguageSelectorNew({required this.onLocaleChange});

  @override
  _LanguageSelectorNewState createState() => _LanguageSelectorNewState();
}

class _LanguageSelectorNewState extends State<LanguageSelectorNew> {
  // Lista de idiomas disponibles con íconos
  final List<Language> _languages = [
    Language(name: 'English', code: 'en', icon: Icons.language),
    Language(name: 'Español', code: 'es', icon: Icons.translate),
    Language(name: 'Português', code: 'pt', icon: Icons.g_translate),
  ];

  // Índice del idioma seleccionado temporalmente
  int? _selectedLanguageIndex;

  // Índice del idioma actualmente aplicado
  int? _currentLanguageIndex;

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLanguageCode = prefs.getString('selected_language_code');

    // Busca el índice del idioma guardado
    if (savedLanguageCode != null) {
      int? index = _languages.indexWhere((language) => language.code == savedLanguageCode);
      if (index != -1) {
        setState(() {
          _currentLanguageIndex = index;
          _selectedLanguageIndex = index; // Se establece como seleccionado
        });
      }
    } else {
      // Si no hay idioma guardado, establece el idioma por defecto (español)
      _currentLanguageIndex = 1; // Por defecto español
      _selectedLanguageIndex = _currentLanguageIndex;
    }
  }

  Future<void> _saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', code);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            TranslationManager.translate('titleLanguage'),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: _languages.map((language) {
              final index = _languages.indexOf(language);
              final isSelected = _selectedLanguageIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLanguageIndex = index;
                  });
                },
                child: Card(
                  color: isSelected ? Colors.blue.shade100 : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              language.icon,
                              // size: 30.0,
                              color: isSelected ? Colors.blue : Colors.grey,
                            ),
                            //SizedBox(height: 10),
                            Text(
                              language.name,
                              style: TextStyle(
                                // fontSize: 14,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Aplicar cambios
                  if (_selectedLanguageIndex != null) {
                    final selectedLanguage = _languages[_selectedLanguageIndex!];
                    widget.onLocaleChange(Locale(selectedLanguage.code));
                    _saveLanguage(selectedLanguage.code); // Guarda el idioma seleccionado
                  }
                },
                child: Text(TranslationManager.translate('acceptButton')),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedLanguageIndex = _currentLanguageIndex; // Revertir cambios
                    Navigator.of(context).pop();
                  });
                },
                child: Text(TranslationManager.translate('cancelButton')),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
bool isNegative(String num) {
  try {
    double number = double.parse(num);  // Intentar convertir el string a un entero
    return number < 0;  // Devuelve true si el número es negativo, false si es positivo o cero
  } catch (e) {
    // Si ocurre una excepción (por ejemplo, si no es un número válido), se maneja aquí
    print('Error al parsear el número: $e');
    return false;  // Devuelve false si no se puede parsear el valor
  }
}
