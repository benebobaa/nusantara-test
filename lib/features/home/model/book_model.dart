class Data {
  int? id;
  int? userId;
  String? isbn;
  String? title;
  String? subtitle;
  String? author;
  String? published;
  String? publisher;
  int? pages;
  String? description;
  String? website;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.isbn,
      this.title,
      this.subtitle,
      this.author,
      this.published,
      this.publisher,
      this.pages,
      this.description,
      this.website,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isbn = json['isbn'];
    title = json['title'];
    subtitle = json['subtitle'];
    author = json['author'];
    published = json['published'];
    publisher = json['publisher'];
    pages = json['pages'];
    description = json['description'];
    website = json['website'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['isbn'] = isbn;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['author'] = author;
    data['published'] = published;
    data['publisher'] = publisher;
    data['pages'] = pages;
    data['description'] = description;
    data['website'] = website;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}