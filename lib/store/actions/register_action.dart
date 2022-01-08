class Register {
  final String email;
  final String password;
  final String name;
  final String image;

  Register(
      {required this.name,
      required this.email,
      required this.password,
      this.image = 'assets/images/person.png'});
}
