
class BrewModel {

  final String _name;
  final String _sugars;
  final int _strength;

  BrewModel({name, sugars, strength}) : _name = name, _sugars = sugars, _strength = strength;

  int get strength => _strength;

  String get sugars => _sugars;

  String get name => _name;
}