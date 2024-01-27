import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instrument_store_mobile/domain/entities/instrument_item_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class InstrumentItemModel extends BaseModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int yearOfPurchase;
  final String manufacturer;
  final String category;
  final String series;
  final String colorString;
  const InstrumentItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.yearOfPurchase,
    required this.manufacturer,
    required this.category,
    required this.series,
    required this.colorString,
  });

  factory InstrumentItemModel.fromEntity(InstrumentItemEntity entity) {
    return const InstrumentItemModel(
      id: 0,
      name: '',
      description: '',
      image: '',
      price: 0,
      yearOfPurchase: 0,
      manufacturer: '',
      category: '',
      series: '',
      colorString: '',
    );
  }

  static List<InstrumentItemModel> mockData() {
    return List.generate(
      10,
      (index) {
        return InstrumentItemModel(
          id: index,
          name: ['Guitar', 'Drums', 'Violin', 'Saxophone'][Random().nextInt(4)],
          description:
              'Ipsum dolor sit amet aliquip consectetur elit minim ut act.',
          image: 'assets/${[
            'guitar',
            'drum',
            'violin',
            'saxophone'
          ][Random().nextInt(4)]}_category.png',
          price: Random().nextDouble() * Random().nextInt(4000),
          yearOfPurchase: Random().nextInt(24) + 2000,
          manufacturer: [
            'Yamaha',
            'Fender',
            'Gibson',
            'Ibanez'
          ][Random().nextInt(4)],
          category: [
            'Guitar',
            'Drums',
            'Violin',
            'Saxophone'
          ][Random().nextInt(4)],
          series: 'Series ${Random().nextInt(9999) * 8721}',
          colorString: [
            'red',
            'blue',
            'green',
            'yellow',
            'orange',
            'purple',
            'pink',
            'brown',
            'grey',
            'black',
            'white',
          ][Random().nextInt(11)],
        );
      },
    );
  }

  Color get color {
    switch (colorString) {
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
      case 'brown':
        return Colors.brown;
      case 'grey':
        return Colors.grey;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      default:
        return Colors.transparent;
    }
  }
}
