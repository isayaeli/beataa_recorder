class Beat{

  final img;
  final beat;
  final title;
  final producer;

  Beat({this.beat, this.img, this.producer, this.title});


 factory Beat.fromJson(Map<String, dynamic> json){
   return Beat(
     img: json['image'],
     beat: json['beat'],
     producer: json['produced_By'],
     title: json['title'],
   
   );
 

}
}
