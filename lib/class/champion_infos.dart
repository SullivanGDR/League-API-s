import 'package:lol_api/class/champion_passive.dart';
import 'package:lol_api/class/champion_spells.dart';

class ChampionInfos {
  final String _id;
  final String _nom;
  final String _icon;
  final String _nomCompact;
  final ChampionPassive _passive;
  final List<ChampionSpells> _spells;
  final List _role;
  final int _hp;
  final int _movespeed;
  final int _armor;
  final int _attackrange;
  final int _attackdamage;
  final double _attackspeed;
  final String _lore;

  ChampionInfos(
      this._id,
      this._nom,
      this._icon,
      this._nomCompact,
      this._passive,
      this._spells,
      this._role,
      this._hp,
      this._movespeed,
      this._armor,
      this._attackrange,
      this._attackdamage,
      this._attackspeed,
      this._lore);

  String getId() {
    return _id;
  }

  String getNom() {
    return _nom;
  }

  String getIcon() {
    return _icon;
  }

  String getNomCompact() {
    return _nomCompact;
  }

  ChampionPassive getPassive() {
    return _passive;
  }

  List<ChampionSpells> getSpells() {
    return _spells;
  }

  String getRole() {
    return _role.toString().substring(1, _role.toString().length - 1);
  }

  int getHp() {
    return _hp;
  }

  int getMoveSpeed() {
    return _movespeed;
  }

  int getArmor() {
    return _armor;
  }

  int getAttackRange() {
    return _attackrange;
  }

  int getAttackDamage() {
    return _attackdamage;
  }

  double getAttackSpeed() {
    return _attackspeed;
  }

  String getLore() {
    return _lore;
  }
}
