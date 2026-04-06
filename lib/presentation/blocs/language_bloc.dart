import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
  @override
  List<Object?> get props => [];
}

class LanguageChanged extends LanguageEvent {
  final Locale locale;
  const LanguageChanged(this.locale);
  @override
  List<Object?> get props => [locale];
}

class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState(this.locale);
  @override
  List<Object?> get props => [locale];
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('en'))) {
    on<LanguageChanged>((event, emit) => emit(LanguageState(event.locale)));
  }
}
