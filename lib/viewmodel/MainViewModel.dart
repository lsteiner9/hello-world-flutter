import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../model/Terrain.dart';

class MainViewModel {

  static const _size = 500;

  Terrain _terrain;
  final _density;
  final _iterationCountStreamController;
  final _populationCountStreamController;

  MainViewModel()
      : _iterationCountStreamController = StreamController<int>(),
        _populationCountStreamController = StreamController<int>(),
        _density = 0.2 {
    _terrain = Terrain(_size, _density, Random());
    _iterationCountStreamController.add(_terrain.iterationCount);
    _populationCountStreamController.add(_terrain.population);
  }

  Stream<int> get iterationCountStream => _iterationCountStreamController.stream;
  Stream<int> get populationCountStream => _populationCountStreamController.stream;

  void iterate() {
    compute(MainViewModel._iterateCA, _terrain).then((_) {
      _iterationCountStreamController.add(_terrain.iterationCount);
      _populationCountStreamController.add(_terrain.population);
    });
  }

  static void _iterateCA(Terrain terrain) {
    terrain.iterate();
  }
}