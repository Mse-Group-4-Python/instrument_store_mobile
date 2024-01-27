import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';
import 'package:instrument_store_mobile/presentation/pages/search/view_models/result_search_view_model.dart';

class SearchPageController extends GetxController with ServiceMixin {
  final TextEditingController searchController = TextEditingController();

  final Rxn<ResultSearchViewModel> resultSearch = Rxn<ResultSearchViewModel>();

  final Rx<LoadingState> loadingState = LoadingState.initial.obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() async {
      if (searchController.text.isEmpty) {
        loadingState.value = LoadingState.initial;
        return;
      }
      await search();
    });
  }

  Future<void> search() async {
    loadingState.value = LoadingState.loading;
    try {
      final result = ResultSearchViewModel.mockData(
        keyword: searchController.text,
      );
      Future.delayed(const Duration(seconds: 2));
      if (result.instruments.isEmpty && result.relatedKeywords.isEmpty) {
        loadingState.value = LoadingState.empty;
        return;
      }
      resultSearch.value = result;
      loadingState.value = LoadingState.success;
    } catch (e) {
      loadingState.value = LoadingState.error;
    }
  }
}
