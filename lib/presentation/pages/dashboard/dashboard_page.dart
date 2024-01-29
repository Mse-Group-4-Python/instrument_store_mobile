import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/category_model.dart';
import 'package:instrument_store_mobile/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:instrument_store_mobile/presentation/pages/product/product_page.dart';
import 'package:instrument_store_mobile/presentation/pages/search/search_page.dart';
import 'package:instrument_store_mobile/presentation/widgets/background_wrapper.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/error_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/loading_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/product_filter/view_models/product_filter_view_model.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    Get.put(DashboardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
              body: BackgroundWrapper(
            child: SafeArea(
              bottom: false,
              child: RefreshIndicator(
                onRefresh: controller.loadCategories,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: AnimationLimiter(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 410),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            const SizedBox(height: 24),
                            const _WelcomeSection(),
                            const SizedBox(height: 8),
                            const _SearchSection(),
                            const SizedBox(height: 24),
                            const _CategorySectionBuilder(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}

class _SearchSection extends GetView<DashboardController> {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Find the best for you',
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.to(
                  () => const SearchPage(),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: 'search-bar',
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: context.theme.colorScheme.surfaceVariant,
                      ),
                      height: 48,
                      width: double.infinity,
                      child: DefaultTextStyle(
                        style: context.theme.textTheme.titleSmall!.copyWith(
                          color: context.theme.colorScheme.onBackground
                              .withOpacity(0.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 24),
                            const SizedBox(width: 8),
                            AnimatedTextKit(
                              onTap: () => Get.to(
                                () => const SearchPage(),
                              ),
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Can we help you find something?',
                                  speed: const Duration(milliseconds: 120),
                                  curve: Curves.decelerate,
                                  cursor: '_',
                                ),
                              ],
                              repeatForever: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(width: 8),
            // const ProductFilterButton()
          ],
        ),
      ],
    );
  }
}

class _WelcomeSection extends GetView<DashboardController> {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Welcome, '.toUpperCase(),
        style: context.textTheme.titleSmall?.copyWith(),
        children: [
          TextSpan(
            text: 'Julliana',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySectionBuilder extends GetView<DashboardController> {
  const _CategorySectionBuilder();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (controller.categoryLoadingState.value) {
          case LoadingState.initial:
          case LoadingState.loading:
            return const LoadingWidget();
          case LoadingState.success:
            return const _CategorySection();
          case LoadingState.error:
            return const ErrorHandleWidget();
          case LoadingState.empty:
            return const EmptyHandleWidget();
        }
      },
    );
  }
}

class _CategorySection extends GetView<DashboardController> {
  const _CategorySection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimationLimiter(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: (controller.categories).map(
            (category) {
              return AnimationConfiguration.staggeredList(
                position: controller.categories.indexOf(category),
                child: FadeInAnimation(
                  child: SlideAnimation(
                    verticalOffset: 50,
                    duration: const Duration(milliseconds: 810),
                    child: LayoutBuilder(
                      builder: (
                        context,
                        constraints,
                      ) {
                        return SizedBox(
                          width: constraints.maxWidth / 2 - 16,
                          child: _CategoryItem(category: category),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.category,
  });

  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductPage(
          initialFilter: ProductFilterViewModel(
            keyword: null,
            category: category,
            manufacturer: null,
            instrumentId: null,
            maxPrice: null,
            minPrice: null,
            sortBy: null,
            sortType: null,
          ),
          initialSearchKeyword: null,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: -20,
              child: Container(
                width: context.width,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                    topRight: Radius.circular(100),
                    topLeft: Radius.circular(100),
                  ),
                  color:
                      context.theme.colorScheme.surfaceVariant.withOpacity(.4),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 180,
                    maxHeight: 180,
                  ),
                  child: Hero(
                    tag: ValueKey(category?.id),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.dstOver,
                      ),
                      child: Image.asset(
                        category?.image ?? '',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                Text(
                  category?.name ?? '',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.aBeeZee().fontFamily,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
