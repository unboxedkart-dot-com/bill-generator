// class UserModel {
//   String name;
//   final int phoneNumber;
//   final String emailId;
//   String gender;
//   // String upiId;
//   // String upiName;

//   UserModel({
//     this.name,
//     this.phoneNumber,
//     this.emailId,
//     this.gender,
//     // this.upiId,
//     // this.upiName
//   });

//   factory UserModel.fromDocument(doc) {
//     return UserModel(
//       name: doc['name'],
//       phoneNumber: doc['phoneNumber'],
//       emailId: doc['emailId'],
//       gender: doc['gender'],
//       // upiId: doc['upiId'],
//       // upiName: doc['upiName']
//     );
//   }
// }

// class PaymentDetailModel {
//   final String upiName;
//   final String upiId;

//   PaymentDetailModel({this.upiName, this.upiId});

//   factory PaymentDetailModel.fromDoc(doc) {
//     bool isNull = doc == null ? true : false;
//     return PaymentDetailModel(
//         upiId: !isNull ? doc['upiId'] : '',
//         upiName: !isNull ? doc['upiName'] : '');
//   }
// }
