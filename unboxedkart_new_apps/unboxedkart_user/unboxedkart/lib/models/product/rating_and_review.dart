class RatingAndReview {
  String title;
  String description;
  int ratingScore;
  String authorType;
  String authorName;
  String authorId;
  String timestamp;


  RatingAndReview({
    this.authorName,
    this.authorId,
    this.authorType,
    this.description,
    this.ratingScore,
    this.timestamp,
    this.title
  });

  factory RatingAndReview.fromDocument(doc){
    return RatingAndReview(
      title: doc['title'],
      description: doc['description'],
      ratingScore: doc['ratingScore'],
      authorType: doc['authorType'],
      authorName: doc['authorName'],
      authorId: doc['authorId'],
      timestamp: doc['timestamp'],
    );
    
  }
}