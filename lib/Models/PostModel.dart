class Review {
  final String? id;
   final String? title;
  final String? content;
  final String? stars;
  final String? author;
  final bool? review_deactivated;
  final String? creation_date;
  final String? modified_date;
    

  Review({
    required this.id,
    required this.title,
    required this.content,
    required this.stars,
    required this.author,
    
   
    
    required this.review_deactivated,
    required this.creation_date,
    required this.modified_date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      stars: json['photo'],
      author: json['author'],
      
     
      
      review_deactivated: json['place_deactivated'],
      creation_date: json['creation_date'],
      modified_date: json['modified_date'],
    );
  }
}
