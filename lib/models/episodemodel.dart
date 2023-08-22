class episionModel {
  final String id, title, rating, date;

  episionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
