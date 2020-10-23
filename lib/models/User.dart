class User{
  String firstName;
  String lastName;
  String email;
  String role;
  User(this.firstName,this.lastName,this.email,this.role);
  User.fromJson(Map<String,dynamic> json){
    firstName = json['firstname'] ;
    lastName = json['lastname'] ;
    email = json['email'] ;
    role = json['role'];
  }
}