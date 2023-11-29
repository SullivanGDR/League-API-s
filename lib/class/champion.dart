class Champion {
  final int _id;
  final String _nom;
  final String _icon;
  final String _nomCompact;

  Champion(this._id, this._nom, this._icon, this._nomCompact);

  int getId() {
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
}
