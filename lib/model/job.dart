class Job {
  final String id;
  final String title;
  final String salary;
  final String company;
  final List<String> info;
  final String category;
  final String head;
  final List<String> publish;

  Job({this.id, this.title, this.salary, this.company, this.info, this.category, this.head, this.publish});

  factory Job.fromJson(Map<String, dynamic> json) {
    var infoFromJson = json['info'];
    var publishFromJson = json['publish'];
    List<String> infoList = new List<String>.from(infoFromJson);
    List<String> publishList = new List<String>.from(publishFromJson);
    return Job(
      title: json['title'],
      salary: json['salary'],
      company: json['company'],
      info: infoList,
      category: json['category'],
      head: json['head'],
      publish: publishList,
    );
  }
}