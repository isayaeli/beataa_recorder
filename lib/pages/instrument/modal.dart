class Instruments{
  final name;
  final img;
  final audio;

  Instruments({ this.audio, this.img, this.name});
  
  factory Instruments.fromJson(Map<String, dynamic>json){
    return Instruments(
      name:json['name'],
      img: json['image'],
      audio: json['sound']
    );
  }

}