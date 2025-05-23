import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeSubscriptionRequested extends HomeEvent {
  const HomeSubscriptionRequested();

  @override
  List<Object> get props => [];
}

final class HomeDidPopNextRequested extends HomeEvent {
  const HomeDidPopNextRequested();

  @override
  List<Object> get props => [];
}

final class GoogleLoginRequested extends HomeEvent {
  const GoogleLoginRequested();

  @override
  List<Object> get props => [];
}

final class KakaoLoginRequested extends HomeEvent {
  const KakaoLoginRequested();

  @override
  List<Object> get props => [];
}

final class HomeLogoutRequested extends HomeEvent {
  const HomeLogoutRequested();

  @override
  List<Object> get props => [];
}
