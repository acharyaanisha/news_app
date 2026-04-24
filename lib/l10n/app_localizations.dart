import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'app_name': 'News Portal',
      'welcome': 'Welcome',
      'login': 'Login',
      'signup': 'Sign Up',
      'email': 'Email',
      'password': 'Password',
      'phone': 'Phone Number',
      'otp': 'OTP',
      'verify': 'Verify',
      'resend_otp': 'Resend OTP',
      'search': 'Search',
      'search_news': 'Search news...',
      'categories': 'Categories',
      'all': 'All',
      'political': 'Political',
      'economic': 'Economic',
      'sports': 'Sports',
      'technology': 'Technology',
      'entertainment': 'Entertainment',
      'health': 'Health',
      'education': 'Education',
      'latest_news': 'Latest News',
      'read_more': 'Read More',
      'settings': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'light_mode': 'Light Mode',
      'dark_mode': 'Dark Mode',
      'english': 'English',
      'nepali': 'Nepali',
      'logout': 'Logout',
      'no_news': 'No news available',
      'loading': 'Loading...',
      'error': 'Error',
      'retry': 'Retry',
      'enter_otp': 'Enter OTP',
      'otp_sent': 'OTP sent to your phone',
      'invalid_otp': 'Invalid OTP',
      'login_success': 'Login successful',
      'signup_success': 'Account created successfully',
    },
    'ne': {
      'app_name': 'समाचार पोर्टल',
      'welcome': 'स्वागतम्',
      'login': 'लगइन',
      'signup': 'साइन अप',
      'email': 'इमेल',
      'password': 'पासवर्ड',
      'phone': 'फोन नम्बर',
      'otp': 'ओटीपी',
      'verify': 'प्रमाणित गर्नुहोस्',
      'resend_otp': 'ओटीपी पुन: पठाउनुहोस्',
      'search': 'खोज्नुहोस्',
      'search_news': 'समाचार खोज्नुहोस्...',
      'categories': 'वर्गहरू',
      'all': 'सबै',
      'political': 'राजनीतिक',
      'economic': 'आर्थिक',
      'sports': 'खेलकुद',
      'technology': 'प्रविधि',
      'entertainment': 'मनोरञ्जन',
      'health': 'स्वास्थ्य',
      'education': 'शिक्षा',
      'latest_news': 'नवीनतम समाचार',
      'read_more': 'थप पढ्नुहोस्',
      'settings': 'सेटिङहरू',
      'theme': 'थिम',
      'language': 'भाषा',
      'light_mode': 'लाइट मोड',
      'dark_mode': 'डार्क मोड',
      'english': 'अंग्रेजी',
      'nepali': 'नेपाली',
      'logout': 'लगआउट',
      'no_news': 'कुनै समाचार उपलब्ध छैन',
      'loading': 'लोड हुँदैछ...',
      'error': 'त्रुटि',
      'retry': 'पुन: प्रयास गर्नुहोस्',
      'enter_otp': 'ओटीपी प्रविष्ट गर्नुहोस्',
      'otp_sent': 'तपाईको फोनमा ओटीपी पठाइएको छ',
      'invalid_otp': 'अवैध ओटीपी',
      'login_success': 'लगइन सफल',
      'signup_success': 'खाता सफलतापूर्वक सिर्जना गरियो',
    },
  };

  String get appName => _localizedValues[locale.languageCode]!['app_name']!;
  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get signup => _localizedValues[locale.languageCode]!['signup']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get phone => _localizedValues[locale.languageCode]!['phone']!;
  String get otp => _localizedValues[locale.languageCode]!['otp']!;
  String get verify => _localizedValues[locale.languageCode]!['verify']!;
  String get resendOtp => _localizedValues[locale.languageCode]!['resend_otp']!;
  String get search => _localizedValues[locale.languageCode]!['search']!;
  String get searchNews =>
      _localizedValues[locale.languageCode]!['search_news']!;
  String get categories =>
      _localizedValues[locale.languageCode]!['categories']!;
  String get all => _localizedValues[locale.languageCode]!['all']!;
  String get political => _localizedValues[locale.languageCode]!['political']!;
  String get economic => _localizedValues[locale.languageCode]!['economic']!;
  String get sports => _localizedValues[locale.languageCode]!['sports']!;
  String get technology =>
      _localizedValues[locale.languageCode]!['technology']!;
  String get entertainment =>
      _localizedValues[locale.languageCode]!['entertainment']!;
  String get health => _localizedValues[locale.languageCode]!['health']!;
  String get education => _localizedValues[locale.languageCode]!['education']!;
  String get latestNews =>
      _localizedValues[locale.languageCode]!['latest_news']!;
  String get readMore => _localizedValues[locale.languageCode]!['read_more']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get lightMode => _localizedValues[locale.languageCode]!['light_mode']!;
  String get darkMode => _localizedValues[locale.languageCode]!['dark_mode']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get nepali => _localizedValues[locale.languageCode]!['nepali']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get noNews => _localizedValues[locale.languageCode]!['no_news']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;
  String get enterOtp => _localizedValues[locale.languageCode]!['enter_otp']!;
  String get otpSent => _localizedValues[locale.languageCode]!['otp_sent']!;
  String get invalidOtp =>
      _localizedValues[locale.languageCode]!['invalid_otp']!;
  String get loginSuccess =>
      _localizedValues[locale.languageCode]!['login_success']!;
  String get signupSuccess =>
      _localizedValues[locale.languageCode]!['signup_success']!;

  String getCategoryName(String category) {
    switch (category) {
      case 'all':
        return all;
      case 'political':
        return political;
      case 'economic':
        return economic;
      case 'sports':
        return sports;
      case 'technology':
        return technology;
      case 'entertainment':
        return entertainment;
      case 'health':
        return health;
      case 'education':
        return education;
      default:
        return category;
    }
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ne'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
