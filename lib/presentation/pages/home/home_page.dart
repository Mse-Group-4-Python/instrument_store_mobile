import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/presentation/pages/dashboard/dashboard_page.dart';
import 'package:instrument_store_mobile/presentation/pages/home/home_controller.dart';
import 'package:instrument_store_mobile/presentation/pages/order/order_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.put(HomeController()) ?? HomeController(),
      builder: (controller) {
        return Scaffold(
          body: TabBarView(
            controller: controller.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              DashboardPage(),
              OrderPage(),
            ],
          ),
          bottomNavigationBar: const _BottonNavigationBar(),
        );
      },
    );
  }
}

class _BottonNavigationBar extends GetView<HomeController> {
  const _BottonNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SalomonBottomBar(
          backgroundColor:
              context.theme.colorScheme.surfaceVariant.withOpacity(0.4),
          currentIndex: controller.tabBarItems.indexOf(
            controller.currentTab,
          ),
          onTap: controller.onChangeTab,
          margin: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            16,
          ),
          itemPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 48,
          ),
          itemShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          curve: Curves.easeOutExpo,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: Text(
                "Home",
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ),

            /// Likes

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.receipt),
              title: Text(
                "Order",
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
