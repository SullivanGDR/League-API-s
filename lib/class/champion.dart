class Champion {
  final int id;
  final String nom;
  final String icon;
  final String nomCompact;

  const Champion({
    required this.id,
    required this.nom,
    required this.icon,
    required this.nomCompact,
  });

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
