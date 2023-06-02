import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/sample_data.dart';

final mealsProvider = Provider(
  (ref) {
    return dummyMeals;
  },
);
