import 'package:flutter/material.dart';
import 'package:instrument_store_mobile/domain/entities/instrument_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class InstrumentSearchModel extends BaseModel {
  final List<InstrumentModel>? instruments;
  final List<String>? suggestionKeyword;

  InstrumentSearchModel({
    required this.instruments,
    required this.suggestionKeyword,
  });

  factory InstrumentSearchModel.fromEntity(InstrumentSearchEntity entity) {
    return InstrumentSearchModel(
      instruments: entity.instruments
          ?.map((e) => InstrumentModel.fromEntity(e))
          .toList(),
      suggestionKeyword: entity.suggestionKeyword,
    );
  }
}

class InstrumentModel extends BaseModel {
  final int id;
  final String image;
  final String name;
  final String description;
  final String colorString;
  final List<String> tags;
  const InstrumentModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.tags,
    required this.colorString,
  });

  factory InstrumentModel.fromEntity(InstrumentEntity entity) {
    return InstrumentModel(
      id: entity.id ?? 0,
      image: _getImageFromName(entity.instrumentName ?? ''),
      name: entity.instrumentName ?? '',
      description: entity.description ?? '',
      tags: entity.tags ?? [],
      colorString: entity.color ?? '',
    );
  }

  static String _getImageFromName(String name) {
    return 'assets/guitar_category.png';
  }

  Color get color {
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'wood':
        return Colors.brown.shade600;
      case 'brown':
        return Colors.brown;
      case 'grey':
        return Colors.grey;
      case 'black':
        return Colors.black;
      case 'natural':
        return Colors.brown.shade300;
      case 'natural trumpets':
        return Colors.yellow.shade700;
      default:
        return Colors.white;
    }
  }

  // static List<InstrumentModel> mockData({required String name}) {
  //   final list = [
  //     const InstrumentModel(
  //       id: 1,
  //       image: 'assets/guitar_category.png',
  //       name: 'Guitar',
  //     ),
  //     const InstrumentModel(
  //       id: 2,
  //       image: 'assets/drum_category.png',
  //       name: 'Drum',
  //     ),
  //     const InstrumentModel(
  //       id: 3,
  //       image: 'assets/violin_category.png',
  //       name: 'Violin',
  //     ),
  //     const InstrumentModel(
  //       id: 4,
  //       image: 'assets/saxophone_category.png',
  //       name: 'Saxophone',
  //     ),
  //   ];

  //   return list.where((element) {
  //     final filterByName =
  //         element.name.toLowerCase().contains(name.toLowerCase());
  //     final condition = filterByName;
  //     return condition;
  //   }).toList();
  // }
}
