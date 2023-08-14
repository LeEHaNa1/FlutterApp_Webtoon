class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title =
            json['title'], // jsonDecode의 반환값이 dynamic이기 때문에 타입은 dynamic이어야 함.
        thumb = json[
            'thumb'], // jsonDecode로 나눌 때, title, thumb, id로 나누어져 있기 때문에 이름에 따라 분류.
        id = json['id'];
}
