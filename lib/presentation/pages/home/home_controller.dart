import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

enum HomeTabBar {
  home,
  order;

  String get name {
    switch (this) {
      case HomeTabBar.home:
        return 'Home';
      case HomeTabBar.order:
        return 'Order';
      default:
        return '';
    }
  }
}

class HomeController extends GetxController
    with ServiceMixin, GetTickerProviderStateMixin {
  final List<HomeTabBar> _tabBarItems = [
    HomeTabBar.home,
    HomeTabBar.order,
  ];
  List<HomeTabBar> get tabBarItems => _tabBarItems;

  late TabController tabController = TabController(
    vsync: this,
    length: _tabBarItems.length,
  );

  late final Rx<HomeTabBar> _currentTab = _tabBarItems.first.obs;

  HomeTabBar get currentTab => _currentTab.value;

  void onChangeTab(int index) {
    if (index == _tabBarItems.indexOf(_currentTab.value)) return;
    _currentTab.value = _tabBarItems[index];
    tabController.animateTo(index);
  }
}
