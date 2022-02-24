class TravelRoute {
  late String? name;
  late String? address;

  TravelRoute({
    required this.name,
    required this.address,
  });
}

var routeList = [
  TravelRoute(
    name: 'Little Caesars',
    address: '6919 NW 122nd St, Oklahoma City, OK 73142',
  ),
  TravelRoute(
    name: "Papa John's",
    address: '7011 Northwest Expy, Oklahoma City, OK 73132',
  ),
  TravelRoute(
    name: 'Pizza Hut',
    address: '12100 N Rockwell Ave, Oklahoma City, OK 73162',
  ),
];
