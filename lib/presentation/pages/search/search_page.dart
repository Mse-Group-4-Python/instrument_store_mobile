import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/presentation/widgets/common_text_field.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/search_loading_widget.dart';
import 'package:lottie/lottie.dart';

import 'search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
        init: Get.put(SearchPageController()),
        builder: (context) {
          return const Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                16,
                32,
                16,
                16,
              ),
              child: Column(
                children: [
                  SizedBox(height: 24),
                  Row(
                    children: [
                      BackButton(),
                      Expanded(child: _SearchTextField()),
                    ],
                  ),
                  SizedBox(height: 32),
                  _SearchResultSection(),
                ],
              ),
            ),
          );
        });
  }
}

class _SearchTextField extends GetView<SearchPageController> {
  const _SearchTextField();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'search-bar',
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return Material(
          child: CommonTextField(
            controller: controller.searchController,
            hintText: 'Input something here...',
            prefixIcon: const Icon(Icons.search_rounded),
            autofocus: true,
          ),
        );
      },
      placeholderBuilder: (context, size, widget) {
        return Material(
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.theme.colorScheme.surfaceVariant,
            ),
          ),
        );
      },
      child: Material(
        child: CommonTextField(
          controller: controller.searchController,
          hintText: 'Input something here...',
          prefixIcon: const Icon(Icons.search_rounded),
          autofocus: true,
        ),
      ),
    );
  }
}

class _SearchResultSection extends GetView<SearchPageController> {
  const _SearchResultSection();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 410),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        reverseDuration: Duration.zero,
        child: SizedBox(
          key: ValueKey(controller.loadingState.value),
          child: Obx(
            () {
              switch (controller.loadingState.value) {
                case LoadingState.initial:
                case LoadingState.loading:
                  return const SearchLoadingWidget();
                case LoadingState.success:
                  return const _SearchResultWidget();
                case LoadingState.empty:
                  return const EmptyHandleWidget(
                    title: 'Không tìm thấy kết quả',
                    content: 'Vui lòng thử lại với từ khóa khác',
                  );
                case LoadingState.error:
                  return const EmptyHandleWidget(
                    title: 'Có lỗi xảy ra',
                    content: 'Vui lòng thử lại',
                    onRetry: null,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _SearchResultWidget extends GetView<SearchPageController> {
  const _SearchResultWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller.resultSearch.value?.relatedKeywords.isNotEmpty == true)
          const _RelatedKeywordList(),
        if (controller.resultSearch.value?.relatedKeywords.isNotEmpty == true &&
            controller.resultSearch.value?.instruments.isNotEmpty == true)
          const Divider(height: 32),
        if (controller.resultSearch.value?.instruments.isNotEmpty == true)
          const _ProductSearchResultList(),
      ],
    );
  }
}

class _RelatedKeywordList extends GetView<SearchPageController> {
  const _RelatedKeywordList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Từ khóa liên quan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.resultSearch.value?.relatedKeywords
                    .map(
                      (keyword) => Chip(
                        label: Text(keyword),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ],
      ),
    );
  }
}

class _ProductSearchResultList extends GetView<SearchPageController> {
  const _ProductSearchResultList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Có thể bạn quan tâm: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final product = controller.resultSearch.value?.instruments[index];
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product?.name ?? '',
                              style: context.theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product?.name ?? '',
                              style: context.theme.textTheme.bodySmall?.copyWith(
                                color: context.theme.colorScheme.onBackground.withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    product?.image ?? '',
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: controller.resultSearch.value?.instruments.length ?? 0,
        ),
      ],
    );
  }
}
