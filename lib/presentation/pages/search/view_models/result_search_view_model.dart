import 'package:instrument_store_mobile/domain/models/instrument_model.dart';

class ResultSearchViewModel {
  final List<String> relatedKeywords;
  final List<InstrumentModel> instruments;

  const ResultSearchViewModel({
    required this.relatedKeywords,
    required this.instruments,
  });

  factory ResultSearchViewModel.fromModel(InstrumentSearchModel model) {
    return ResultSearchViewModel(
      relatedKeywords: model.suggestionKeyword ?? [],
      instruments: model.instruments ?? [],
    );
  }

  // static ResultSearchViewModel mockData({required String keyword}) {
  //   final keywords = [
  //     'keyword_1',
  //     'keyword_2',
  //     'keyword_3',
  //     'keyword_4',
  //   ];
  //   // final instrument = InstrumentModel.mockData(name: keyword);
  //   final relatedKeywords = keywords.where((element) {
  //     final filterByName =
  //         element.toLowerCase().contains(keyword.toLowerCase());
  //     final condition = filterByName;
  //     return condition;
  //   }).toList();
  //   return ResultSearchViewModel(
  //     relatedKeywords: relatedKeywords,
  //     instruments: instrument,
  //   );
  // }
}
