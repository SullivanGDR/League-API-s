class ChampionSpells {
  final String _name;
  final String _description;
  final String _icon;
  final List _cooldown;

  ChampionSpells(this._name, this._description, this._icon, this._cooldown);

  String getName() {
    return _name;
  }

  String getDescription() {
    return _description;
  }

  String getIcon() {
    return _icon;
  }

  List getCoolDown() {
    return _cooldown;
  }
}
