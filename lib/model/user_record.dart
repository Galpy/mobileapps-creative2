class UserRecord {
  late String email;
  late String password;
  late String name;
  late String phone;
  late int age;

  UserRecord({
    this.email = '',
    this.password = '',
    this.name = '',
    this.phone = '',
    this.age = 0,
  });

  UserRecord clone() {
    var copy = UserRecord(
      email: email,
      password: password,
      name: name,
      phone: phone,
      age: age,
    );
    return copy;
  }

  void copyFrom(UserRecord obj) {
    email = obj.email;
    password = obj.password;
    name = obj.name;
    phone = obj.phone;
    age = obj.age;
  }

  @override
  String toString() {
    return 'UserRecord[name = $name ($email, $password)]';
  }
}

List<UserRecord> fakeDB = [
  UserRecord(
    email: '1@test.com',
    password: '111111',
    name: 'One John',
    phone: '1112223333',
  ),
  UserRecord(
    email: '2@test.com',
    password: '222222',
    name: 'Two Mary',
    phone: '9992223333',
  ),
];
