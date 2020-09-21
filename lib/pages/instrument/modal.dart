class Guitars{
  final name;
  final img;
  final audio;

  Guitars({ this.audio, this.img, this.name});
  
  factory Guitars.fromJson(Map<String, dynamic>json){
    return Guitars(
      name:json['name'],
      img: json['image'],
      audio: json['sound']
    );
  }

}



class Pianos{
  final name;
  final img;
  final audio;

  Pianos({ this.audio, this.img, this.name});

  factory Pianos.fromJson(Map<String, dynamic>json){
    return Pianos(
        name:json['name'],
        img: json['image'],
        audio: json['sound']
    );
  }

}


class Marimbas{
  final name;
  final img;
  final audio;

  Marimbas({ this.audio, this.img, this.name});

  factory Marimbas.fromJson(Map<String, dynamic>json){
    return Marimbas(
        name:json['name'],
        img: json['image'],
        audio: json['sound']
    );
  }

}



class Trumpets{
  final name;
  final img;
  final audio;

  Trumpets({ this.audio, this.img, this.name});

  factory Trumpets.fromJson(Map<String, dynamic>json){
    return Trumpets(
        name:json['name'],
        img: json['image'],
        audio: json['sound']
    );
  }

}