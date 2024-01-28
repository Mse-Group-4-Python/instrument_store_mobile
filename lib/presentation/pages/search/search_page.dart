import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/presentation/widgets/common_text_field.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/error_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/search_loading_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/text_highlight_keyword.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: GetBuilder<SearchPageController>(
          init: Get.put(SearchPageController()),
          builder: (controller) {
            return Scaffold(
              body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  32,
                  16,
                  16,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        BackButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Get.back();
                          },
                        ),
                        const Expanded(child: _SearchTextField()),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const _SearchResultSection(),
                  ],
                ),
              ),
            );
          }),
    );
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
                  return EmptyHandleWidget(
                    title: 'No result found',
                    content: 'Try another keyword',
                    onRetry: () {
                      controller.search();
                    },
                  );
                case LoadingState.error:
                  return ErrorHandleWidget(
                    title: 'Oops! Something went wrong',
                    content: 'Please try again later',
                    onRetry: () {
                      controller.search();
                    },
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
            'Từ khóa liên quan:',
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
                        label: TextHighlightKeyword(
                          keyword: controller.searchController.text,
                          text: keyword,
                          basicStyle: context.theme.textTheme.bodySmall,
                        ),
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
                  padding: const EdgeInsets.all(16),
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
                            Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    color: product?.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Obx(
                                  () => TextHighlightKeyword(
                                    keyword: controller.searchController.text,
                                    text: controller.resultSearch.value
                                            ?.instruments[index].name ??
                                        '',
                                    basicStyle: context
                                        .theme.textTheme.titleSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product?.description ?? '',
                              style:
                                  context.theme.textTheme.bodySmall?.copyWith(
                                color: context.theme.colorScheme.onBackground
                                    .withOpacity(.5),
                              ),
                            ),
                            if (product?.tags.isNotEmpty == true) ...[
                              const SizedBox(height: 8),
                              Obx(
                                () => TextHighlightKeyword(
                                  keyword: controller.searchController.text,
                                  text: controller.resultSearch.value
                                          ?.instruments[index].tags
                                          .join(', ') ??
                                      '',
                                  basicStyle: context.theme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: Colors.orange.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
                    fit: BoxFit.contain,
                    width: 120,
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
