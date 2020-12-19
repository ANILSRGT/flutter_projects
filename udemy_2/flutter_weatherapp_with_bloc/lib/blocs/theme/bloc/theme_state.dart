part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class UygulamaTemasi extends ThemeState {
  final ThemeData tema;
  final MaterialColor renk;

  UygulamaTemasi({@required this.tema, @required this.renk});

  @override
  List<Object> get props => [tema, renk];
}
