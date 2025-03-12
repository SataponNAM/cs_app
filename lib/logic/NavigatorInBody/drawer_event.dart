part of 'drawer_bloc.dart';

sealed class DrawerEvent extends Equatable {
  const DrawerEvent();
  
  @override
  List<Object?> get props => [];
}

class NavigateTo extends DrawerEvent {
  final NavItem destination;

  const NavigateTo(this.destination);

  @override
  List<Object?> get props => [destination];
}