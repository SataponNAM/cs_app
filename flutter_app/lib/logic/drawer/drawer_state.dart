part of 'drawer_bloc.dart';

enum NavItem {
  home,
  aboutMenu,
  newsMenu,
  downloadMenu,
  serviceMenu,
  csbPage,
  ruleMenu,
}

class DrawerState extends Equatable {
  final NavItem selectedItem;

  const DrawerState(this.selectedItem);

  @override
  List<Object?> get props => [selectedItem,];
}
