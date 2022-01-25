class Band {

  String? id;
  String? name;
  int? votes;
  String? img;

  Band({
    this.id,
    this.name,
    this.votes,
    this.img
  });

  factory Band.fromMap( Map<String, dynamic> obj )=> Band(
    id: obj.containsKey('id') ? obj['id'] : 'no-id',
    name: obj.containsKey('name') ? obj['name'] : 'no-name',
    votes: obj.containsKey('votes') ? obj['votes'] : 'no-votes',
    img : obj.containsKey('img') ? obj['img'] : 'no-img'
  );

}