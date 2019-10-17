class Company {
  final String id;
  final String company;
  final String logo;
  final List<String> info;
  final String hot;

  Company({this.id, this.company, this.logo, this.info, this.hot});

  factory Company.fromJson(Map<String, dynamic> json) {
    var infoFromJson = json['info'];
    List<String> infoList = new List<String>.from(infoFromJson);
    return Company(
      id: json['id'],
      company: json['company'],
      logo: json['logo'],
      info: infoList,
      hot: json['hot']
    );
  }
}