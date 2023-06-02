// import 'package:flutter/cupertino.dart';

// class SkeletonContainer extends StatelessWidget {
//   final double? width;
//   final double? height;
//   final ShapeBorder shapeBorder;
  
//   const SkeletonContainer({
//     Key key,
//     this.width,
//     this.height,this.shapeBorder,
//   }) : super(key: key);
  
//   const SkeletonContainer.rectangular(
//       {this.width,
//       this.height,
//       this.shapeBorder = const RoundedRectangleBorder(),
//       Key? key})
//       : super(key: key);

//   const SkeletonContainer.circular(
//       {this.width,
//       this.height,
//       this.shapeBorder = const CircleBorder(),
//       Key key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.deepPurple[300]!,
//       highlightColor: Colors.grey[300]!,
//       period: const Duration(milliseconds: 2000),
//       child: Container(
//         width: width,
//         height: height,
//         decoration:
//             ShapeDecoration(color: Colors.deepPurple[200]!, shape: shapeBorder),
//       ),
//     );
//   }
// }