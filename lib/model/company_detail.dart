class CompanyDetail {
  final String id;
  final String inc;
  final List companyImgsResult;

  CompanyDetail({this.id, this.inc, this.companyImgsResult});

  factory CompanyDetail.fromJson(Map<String, dynamic> json) {
    return CompanyDetail(
        id: json['id'],
        inc: json['inc'].replaceAll("<br>","\n"),
        companyImgsResult: json['companyImgsResult'] as List);
  }
}