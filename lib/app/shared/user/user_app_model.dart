const kRoleAdmin = 'Admin';
const kRoleAuthor = 'Autor';
const kRoleUser = 'Usuario';

class UserApp {
  final String? uid;
  final String? loginType;
  final String? fullName;
  final String? email;
  final String? userRole;
  final String? userImageUrl;
  final String? userImageFileName;
  final String? curriculum;
  final String? site;
  final String? contact;
  final String? date;
  final List<String?>? favorites;

  UserApp({this.uid, 
  this.loginType,
  this.fullName, 
  this.email, 
  this.userRole,
  this.contact,
  this.site,
  this.curriculum, 
  this.favorites, 
  this.date,
  this.userImageFileName,
  this.userImageUrl});

  UserApp.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        loginType = data['loginType'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        curriculum = data['curriculum'],
        contact = data['contact'],
        site = data['site'],
        date = data['date'],
        userImageUrl = data['userImageUrl'],
        userImageFileName = data['userImageFileName'],
        favorites = data['favorites'] == null ? [] : List<String>.from(data['favorites'].map((x) => x));

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'loginType' : loginType,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'site': site,
      'curriculum': curriculum,
      'contact': contact,
      'date': date,
      'userImageUrl':userImageUrl,
      'userImageFileName': userImageFileName,
      'favorites': favorites == null ? [] : List<String>.from(favorites!.map((x) => x)),
    };
  }
}