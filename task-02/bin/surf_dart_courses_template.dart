import 'package:surf_dart_courses_template/surf_dart_courses_template.dart';

void main(List<String> arguments) {
  final airport = Airport(title: 'Бегишево',
      address: 'Аэропорт Бегишево расположен в 21 км от города Нижнекамск и в 24 км от города Набережные Челны.',
      phone: '8 8552 796 670',
      code: 'NBC',
      type: AirportType.external,
      airplanes: [Airplane.passenger(title: 'Ty-144', pilot: 'Чкалов')],
      dispatchers: {'Иванов Дмитрий'});

  print(airport);

  if (airport.airplanes.isNotEmpty){
    final airplane = airport.airplanes.first;
    airplane.toFly();

    print(airplane);
  }
}
