class EventModel {
  int? id;
  int? index;
  bool? archived;
  bool? featured;
  bool? hasWebcast;
  String? webcastUrl;
  bool? onlineOnly;
  int? eventTypeId;
  int? orgId;
  String? name;
  String? shortDescription;
  String? description;
  String? descriptionText;
  int? eventDateId;
  bool? hasImage1;
  bool? requiresRegistration;
  int? registrationCount;
  int? maxParticipants;
  String? startTimestamp;
  String? startIso;
  String? endTimestamp;
  String? endIso;
  Venue? venue;

  EventModel(
      {this.id,
      this.index,
      this.archived,
      this.featured,
      this.hasWebcast,
      this.webcastUrl,
      this.onlineOnly,
      this.eventTypeId,
      this.orgId,
      this.name,
      this.shortDescription,
      this.description,
      this.descriptionText,
      this.eventDateId,
      this.hasImage1,
      this.requiresRegistration,
      this.registrationCount,
      this.maxParticipants,
      this.startTimestamp,
      this.startIso,
      this.endTimestamp,
      this.endIso,
      this.venue});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    index = json['index'];
    archived = json['archived'];
    featured = json['featured'];
    hasWebcast = json['hasWebcast'];
    webcastUrl = json['webcastUrl'];
    onlineOnly = json['onlineOnly'];
    eventTypeId = json['eventTypeId'];
    orgId = json['orgId'];
    name = json['name'];
    shortDescription = json['shortDescription'];
    description = json['description'];
    descriptionText = json['descriptionText'];
    eventDateId = json['eventDateId'];
    hasImage1 = json['hasImage1'];
    requiresRegistration = json['requiresRegistration'];
    registrationCount = json['registrationCount'];
    maxParticipants = json['maxParticipants'];
    startTimestamp = json['startTimestamp'];
    startIso = json['startIso'];
    endTimestamp = json['endTimestamp'];
    endIso = json['endIso'];
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['index'] = index;
    data['archived'] = archived;
    data['featured'] = featured;
    data['hasWebcast'] = hasWebcast;
    data['webcastUrl'] = webcastUrl;
    data['onlineOnly'] = onlineOnly;
    data['eventTypeId'] = eventTypeId;
    data['orgId'] = orgId;
    data['name'] = name;
    data['shortDescription'] = shortDescription;
    data['description'] = description;
    data['descriptionText'] = descriptionText;
    data['eventDateId'] = eventDateId;
    data['hasImage1'] = hasImage1;
    data['requiresRegistration'] = requiresRegistration;
    data['registrationCount'] = registrationCount;
    data['maxParticipants'] = maxParticipants;
    data['startTimestamp'] = startTimestamp;
    data['startIso'] = startIso;
    data['endTimestamp'] = endTimestamp;
    data['endIso'] = endIso;
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    return data;
  }
}

class Venue {
  int? id;
  String? name;
  String? address;
  String? postalCode;
  String? locality;
  String? country;
  String? email;
  String? phone;

  Venue(
      {this.id,
      this.name,
      this.address,
      this.postalCode,
      this.locality,
      this.country,
      this.email,
      this.phone});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    postalCode = json['postalCode'];
    locality = json['locality'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['postalCode'] = postalCode;
    data['locality'] = locality;
    data['country'] = country;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
