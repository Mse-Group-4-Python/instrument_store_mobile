// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/presentation/widgets/common_text_field.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/error_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/loading_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/search_loading_widget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'order_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Get.put(OrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return KeyboardDismisser(
      child: GetBuilder<OrderController>(
        builder: (controller) {
          return const Scaffold(
            body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const _SearchTextField(),
                    const SizedBox(height: 24),
                    // blank page, when user search -> display result
                    const _SearchResultSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SearchTextField extends GetView<OrderController> {
  const _SearchTextField();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CommonTextField(
        controller: controller.phoneSearchController,
        hintText: 'Search by phone number',
        prefixIcon: const Icon(Icons.search_rounded),
        autofocus: true,
      ),
    );
  }
}

// class _OrderListSectionBuilder extends GetView<OrderController> {
//   const _OrderListSectionBuilder();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       switch (controller.loadingState.value) {
//         case LoadingState.initial:
//         case LoadingState.loading:
//           return const LoadingWidget();
//         case LoadingState.success:
//           return ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: controller.customerOrders.length,
//             itemBuilder: (context, index) {
//               final order = controller.customerOrders[index];
//               return _CustomerOrderSection();
//             },
//           );
//         case LoadingState.empty:
//           return const EmptyHandleWidget();
//         case LoadingState.error:
//           return const ErrorHandleWidget();
//       }
//     });
//   }
// }

// class _CustomerOrderSection extends GetView<OrderController> {
//   const _CustomerOrderSection();

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Customer Orders',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         const _OrderListSectionBuilder(),
//       ],
//     );
//   }
// }

class _SearchResultSection extends GetView<OrderController> {
  const _SearchResultSection();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadingState.value) {
        case LoadingState.initial:
        case LoadingState.loading:
          return const SearchLoadingWidget(text: 'Input phone number...');
        case LoadingState.success:
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.customerOrders.length,
            itemBuilder: (context, index) {
              final order = controller.customerOrders[index];
              return Container(
                height: 10,
                color: Colors.red,
              );
            },
          );
        case LoadingState.empty:
          return const EmptyHandleWidget();
        case LoadingState.error:
          return const ErrorHandleWidget();
      }
    });
  }
}
