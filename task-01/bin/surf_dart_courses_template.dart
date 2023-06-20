import 'package:surf_dart_courses_template/surf_dart_courses_template.dart';

void main(List<String> arguments) {
  final allMap = <Countries, List<Territory>>{};
  allMap.addAll(mapBefore2010);
  allMap.addAll(mapAfter2010);

  final machineryList = <AgriculturalMachinery>[];
  for (var e in allMap.entries) {
    for (var t in e.value) {
      machineryList.addAll(t.machineries);
    }
  }

  final releaseDates = <int>[];
  final machinerySet = machineryList.toSet();
  for (var m in machinerySet) {
    releaseDates.add(DateTime.now().year - m.releaseDate.year);
  }

  print('Cредний возраст всей техники: ${releaseDates.reduce((a, b) => a + b) / machinerySet.length}');

  releaseDates.sort((a, b) => b.compareTo(a));

  final fiftyPercent = machinerySet.length ~/ 2;

  final oldDates = releaseDates.take(fiftyPercent);

  print('Cредний возраст техники для 50% самой старой техники: ${oldDates.reduce((a, b) => a + b) / fiftyPercent}');
}
