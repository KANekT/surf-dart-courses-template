import 'package:surf_dart_courses_template/surf_dart_courses_template.dart';

void main() {
  final opponent = PokerPlayer();

  /// Это часть первого задания. [Strategy] пока не сущестивует.
  ///
  /// Опишите его.
  final Strategy fakeStrategy = (p0, p1) {
    /// Ваш код - здесь
    print(p0);
    print(p1);
    final double result = doubleInRange(0, 1);
    print(result);
    return result;
  };

  opponent.calculateProbabilities(
    ['Nine of diamonds', 'king of hearts'],
    fakeStrategy,
  );
}