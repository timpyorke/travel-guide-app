enum AppLangType {
  en(langCode: 'en', countryCode: 'us'),
  th(langCode: 'th', countryCode: 'th'),
  zh(langCode: 'zh', countryCode: 'cn');

  const AppLangType({required this.langCode, this.countryCode});

  final String langCode;
  final String? countryCode;
}
