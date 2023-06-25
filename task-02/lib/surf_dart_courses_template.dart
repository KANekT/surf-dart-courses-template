class Airport {
  final String title;
  final String address;
  final String phone;
  final String code;
  String? description;
  final AirportType type;
  final List<Airplane> airplanes;
  final Set<String> dispatchers;
  static const String country = 'Russia';

  Airport({
    required this.title,
    required this.address,
    required this.phone,
    required this.code,
    required this.type,
    required this.airplanes,
    required this.dispatchers
  });

  @override String toString() {
    return 'Airport title=$title, address is $address, phone=$phone, code=$code, country=$country';
  }
}

enum AirportType {
  internal,
  external,
}

class Airplane {
  final String title;
  String? description;
  final AirplaneType _type;
  final String pilot;

  Airplane(this._type, {
    required this.title,
    required this.pilot
  });

  Airplane.passenger({
    required this.title,
    required this.pilot
  }):
      _type = AirplaneType.passenger;

  Airplane.cargo({
    required this.title,
    required this.pilot
  }):
        _type = AirplaneType.cargo;

  Airplane.mail({
    required this.title,
    required this.pilot
  }):
        _type = AirplaneType.mail;

  Airplane.training({
    required this.title,
    required this.pilot
  }):
        _type = AirplaneType.training;

  @override String toString() {
    return 'title=$title, description is $description, type=$_type, pilot=$pilot';
  }

  void toFly(){
    print('Airplane $title with $pilot fly');
  }
}

enum AirplaneType {
  passenger,
  cargo,
  mail,
  training
}