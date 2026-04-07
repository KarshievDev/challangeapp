import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/mock_auth_repository.dart';
import 'data/repositories/mock_challenge_repository.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/challenge_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/blocs/auth_bloc.dart';
import 'presentation/blocs/language_bloc.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/home/main_screen.dart';
import 'presentation/pages/onboarding/interests_page.dart';
import 'core/utils/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  // Initialize Firebase (Assuming configurations are set up by user or in next steps)
  // await Firebase.initializeApp(); 
  
  runApp(const LevelUpApp());
}

class LevelUpApp extends StatefulWidget {
  const LevelUpApp({super.key});

  @override
  State<LevelUpApp> createState() => _LevelUpAppState();
}

class _LevelUpAppState extends State<LevelUpApp> {
  late final AuthRepository _mockAuth;
  late final ChallengeRepository _mockChallenge;

  @override
  void initState() {
    super.initState();
    _mockAuth = MockAuthRepository()..init();
    _mockChallenge = MockChallengeRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => _mockAuth),
        RepositoryProvider<ChallengeRepository>(create: (_) => _mockChallenge),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: _mockAuth)..add(AuthStarted()),
          ),
          BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            return MaterialApp(
              title: 'LevelUp Challenge',
              debugShowCheckedModeBanner: false,
              locale: languageState.locale,
              supportedLocales: const [
                Locale('en'),
                Locale('ru'),
                Locale('uz'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.dark,
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    if (state.user.interests.isEmpty) {
                      return const InterestsPage();
                    }
                    return const MainScreen();
                  } else if (state is AuthUnauthenticated) {
                    return const LoginPage();
                  }
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
