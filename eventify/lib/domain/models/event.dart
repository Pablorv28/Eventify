class Event {
  final String id;
  final int? organizerId;
  final String title;
  final String? description;
  final String category;
  final DateTime startTime;
  final DateTime? endTime;
  final String? location;
  final double? latitude;
  final double? longitude;
  final int? maxAttendees;
  final double? price;
  final String imageUrl;
  final bool? deleted;

  Event({
    required this.id,
    this.organizerId,
    required this.title,
    this.description,
    required this.category,
    required this.startTime,
    this.endTime,
    this.location,
    this.latitude,
    this.longitude,
    this.maxAttendees,
    this.price,
    required this.imageUrl,
    this.deleted,
  });

  // ENDPOINT --> /EVENTS
  factory Event.fromFetchEventsJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.parse(json['start_time']),
      imageUrl: json['image_url'],
      category: json['category'],
    );
  }

}