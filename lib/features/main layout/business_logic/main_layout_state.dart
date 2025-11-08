
abstract class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}

class AppBottomNavState extends MainLayoutState {
  final int currentIndex;

   AppBottomNavState(this.currentIndex);
}
