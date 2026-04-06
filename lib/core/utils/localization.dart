import 'dart:ui';
import 'package:flutter/widgets.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Ready to level up,',
      'streak': 'Current Streak',
      'active_challenges': 'Your Active Challenges',
      'explore': 'Explore',
      'settings': 'Settings',
      'sign_out': 'Sign Out',
      'delete_account': 'Delete Account',
      'interests_title': 'Personalize Your Journey',
      'interests_sub': 'Select your interests to curate the best challenges for you.',
      'get_started': 'Get Started',
      'sign_in': 'Sign In',
      'day': 'Day',
      'competitions': 'Competitions',
      'board': 'Board',
      'profile': 'Profile',
      'home': 'Home',
    },
    'ru': {
      'welcome': 'Готовы к новому уровню,',
      'streak': 'Текущая серия',
      'active_challenges': 'Ваши активные задания',
      'explore': 'Обзор',
      'settings': 'Настройки',
      'sign_out': 'Выйти',
      'delete_account': 'Удалить аккаунт',
      'interests_title': 'Персонализируйте свой путь',
      'interests_sub': 'Выберите свои интересы, чтобы мы подобрали лучшие задания для вас.',
      'get_started': 'Начать',
      'sign_in': 'Войти',
      'day': 'День',
      'competitions': 'Соревнования',
      'board': 'Таблица',
      'profile': 'Профиль',
      'home': 'Главная',
    },
    'uz': {
      'welcome': 'Yangi darajaga tayyormisiz,',
      'streak': 'Davomiylik',
      'active_challenges': 'Sizning faol vazifalaringiz',
      'explore': 'Ko\'rish',
      'settings': 'Sozlamalar',
      'sign_out': 'Chiqish',
      'delete_account': 'Hisobni o\‘chirish',
      'interests_title': 'Sayohatingizni moslashtiring',
      'interests_sub': 'Siz uchun eng yaxshi vazifalarni tanlash uchun qiziqishlaringizni belgilang.',
      'get_started': 'Boshlash',
      'sign_in': 'Kirish',
      'day': 'Kun',
      'competitions': 'Musobaqalar',
      'board': 'Reyting',
      'profile': 'Profil',
      'home': 'Asosiy',
    },
  };

  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get streakLabel => _localizedValues[locale.languageCode]!['streak']!;
  String get activeChallenges => _localizedValues[locale.languageCode]!['active_challenges']!;
  String get explore => _localizedValues[locale.languageCode]!['explore']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get signOut => _localizedValues[locale.languageCode]!['sign_out']!;
  String get deleteAccount => _localizedValues[locale.languageCode]!['delete_account']!;
  String get interestsTitle => _localizedValues[locale.languageCode]!['interests_title']!;
  String get interestsSub => _localizedValues[locale.languageCode]!['interests_sub']!;
  String get getStarted => _localizedValues[locale.languageCode]!['get_started']!;
  String get signIn => _localizedValues[locale.languageCode]!['sign_in']!;
  String get day => _localizedValues[locale.languageCode]!['day']!;
  String get board => _localizedValues[locale.languageCode]!['board']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;

  static AppLocalization of(context) {
    return AppLocalization(Localizations.localeOf(context));
  }
}
