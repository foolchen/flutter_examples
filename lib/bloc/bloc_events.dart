import 'package:equatable/equatable.dart';

abstract class BlocEvent extends Equatable {}

class Cancel extends BlocEvent {
  @override
  String toString() => "Cancel";
}

/// 页面重新加载，覆盖UI
class Reload extends BlocEvent {}

/// 页面刷新（下拉刷新，不覆盖UI）
class Refresh extends BlocEvent {}

/// 在原有数据基础上获取新数据（上拉加载）
class Fetch extends BlocEvent {}
