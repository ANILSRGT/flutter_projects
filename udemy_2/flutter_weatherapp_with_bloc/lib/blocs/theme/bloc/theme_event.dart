part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class TemaDegistirEvent extends ThemeEvent {
  final String havaDurumuKisaltmasi;

  TemaDegistirEvent({@required this.havaDurumuKisaltmasi});

  @override
  List<Object> get props => [havaDurumuKisaltmasi];
}
