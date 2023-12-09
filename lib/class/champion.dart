class Champion {
  final int id;
  final String nom;
  final String icon;
  final String nomCompact;

  Champion(this.id, this.nom, this.icon, this.nomCompact);

  int getId() {
    return id;
  }

  String getNom() {
    return nom;
  }

  String getIcon() {
    return icon;
  }

  String getNomCompact() {
    return nomCompact;
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nom': nom,
      'icon': icon,
      'nomCompact': nomCompact
    };
  }
}
