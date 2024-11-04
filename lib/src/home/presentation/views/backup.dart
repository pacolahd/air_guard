// class AirQualityUI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white, // Adjust background if necessary
//
//           border: Border.all(color: Colors.white),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         // height: 200,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Air Quality Index',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Last Updated: 12:00 PM',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               height: 150,
//               child: LineChart(LineChartData(
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: [
//                       FlSpot(0, 70),
//                       FlSpot(1, 80),
//                       FlSpot(2, 90),
//                       FlSpot(3, 75),
//                       FlSpot(4, 50),
//                       FlSpot(5, 85),
//                       FlSpot(6, 65),
//                     ],
//                     isCurved: true,
//                     color: Colors.blue,
//                     belowBarData: BarAreaData(
//                         show: true, color: Colors.blue.withOpacity(0.3)),
//                   ),
//                 ],
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       interval: 1, // Interval between titles
//                       getTitlesWidget: (value, meta) {
//                         switch (value.toInt()) {
//                           case 0:
//                             return Text('Sun',
//                                 style: TextStyle(color: Colors.grey));
//                           case 1:
//                             return Text('Mon',
//                                 style: TextStyle(color: Colors.grey));
//                           case 2:
//                             return Text('Tue',
//                                 style: TextStyle(color: Colors.grey));
//                           case 3:
//                             return Text('Wed',
//                                 style: TextStyle(color: Colors.grey));
//                           case 4:
//                             return Text('Thu',
//                                 style: TextStyle(color: Colors.grey));
//                           case 5:
//                             return Text('Fri',
//                                 style: TextStyle(color: Colors.grey));
//                           case 6:
//                             return Text('Sat',
//                                 style: TextStyle(color: Colors.grey));
//                           default:
//                             return Text('');
//                         }
//                       },
//                       reservedSize: 20,
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: false,
//                       reservedSize: 25,
//                     ),
//                   ),
//                   topTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   rightTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                 ),
//                 gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: false,
//                     getDrawingHorizontalLine: (value) {
//                       return FlLine(
//                         color: Colors.grey,
//                         strokeWidth: 0.5,
//                       );
//                     }),
//                 borderData: FlBorderData(show: false),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DateAQICard extends StatelessWidget {
//   final String day;
//   final int aqi;
//   final bool isSelected;
//
//   DateAQICard({required this.day, required this.aqi, this.isSelected = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.white : Colors.transparent,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: isSelected ? Colors.blue : Colors.white,
//           width: 1,
//         ),
//       ),
//       width: 40,
//       height: 60,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             '$aqi',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//               color: aqi > 40
//                   ? Colors.orange
//                   : isSelected
//                   ? Colors.blue
//                   : Colors.white,
//             ),
//           ),
//           Text(
//             day,
//             style: TextStyle(
//               fontSize: 12,
//               color: isSelected ? Colors.blue : Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




//
// Container(
// margin: EdgeInsets.all(10),
// // height: context.height * 0.4,
// width: double.infinity,
// // color: Colors.blue,
// child: Column(
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 15, vertical: 5),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Emergency Contacts',
// style: TextStyle(
// fontSize: 15,
// color: Colors.blue,
// ),
// ),
// Text(
// 'See all',
// style: TextStyle(
// fontSize: 13,
// color: Colors.blue,
// ),
// ),
// ],
// ),
// ),
// SizedBox(
// height: 25,
// ),
// Row(
// children: [
// Container(
// margin: const EdgeInsets.symmetric(
// horizontal: 8),
// child: Column(
// children: [
// circleAvatarWithUserPicture(
// url:
// 'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
// radius: 30),
// Text(
// 'Judette Adjetey',
// style: TextStyle(
// fontSize: 15,
// color: Colors.blue),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.blue,
// minimumSize: Size(
// 20,
// 10,
// )),
// onPressed: () {},
// child: Text(
// '       Call       ',
// style: TextStyle(height: .06),
// ),
// )
// ],
// ),
// ),
// Container(
// margin: const EdgeInsets.symmetric(
// horizontal: 8),
// child: Column(
// children: [
// circleAvatarWithUserPicture(
// url:
// 'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
// radius: 30),
// Text(
// 'Judette Adjetey',
// style: TextStyle(
// fontSize: 15,
// color: Colors.blue),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.blue,
// minimumSize: Size(
// 20,
// 10,
// )),
// onPressed: () {},
// child: Text(
// '       Call       ',
// style: TextStyle(height: .06),
// ),
// )
// ],
// ),
// ),
// Container(
// margin: const EdgeInsets.only(left: 13),
// child: Column(
// children: [
// circleAvatarWithUserPicture(
// url:
// 'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
// radius: 30),
// Text(
// 'Judette Adjetey',
// style: TextStyle(
// fontSize: 15,
// color: Colors.blue),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.blue,
// minimumSize: Size(
// 20,
// 10,
// )),
// onPressed: () {},
// child: Text(
// '       Call       ',
// style: TextStyle(height: .06),
// ),
// )
// ],
// ),
// ),
// ],
// ),
// SizedBox(
// height: 25,
// ),
// Row(
// children: [
// Container(
// margin: const EdgeInsets.symmetric(
// horizontal: 8),
// child: Column(
// children: [
// circleAvatarWithUserPicture(
// url:
// 'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
// radius: 30),
// Text(
// 'Judette Adjetey',
// style: TextStyle(
// fontSize: 15,
// color: Colors.blue),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.blue,
// minimumSize: Size(
// 20,
// 10,
// )),
// onPressed: () {},
// child: Text(
// '       Call       ',
// style: TextStyle(height: .06),
// ),
// )
// ],
// ),
// ),
// Container(
// margin: const EdgeInsets.symmetric(
// horizontal: 8),
// child: Column(
// children: [
// circleAvatarWithUserPicture(
// url:
// 'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
// radius: 30),
// Text(
// 'Judette Adjetey',
// style: TextStyle(
// fontSize: 15,
// color: Colors.blue),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.blue,
// minimumSize: Size(
// 20,
// 10,
// )),
// onPressed: () {},
// child: Text(
// '       Call       ',
// style: TextStyle(height: .06),
// ),
// )
// ],
// ),
// ),
// Container(
// margin: const EdgeInsets.only(left: 13),
// child: Column(
// children: [
// circleAvatarWithUserPicture(
// url:
// 'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png',
// radius: 30),
// Text(
// 'Judette Adjetey',
// style: TextStyle(
// fontSize: 15,
// color: Colors.blue),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.blue,
// minimumSize: Size(
// 20,
// 10,
// )),
// onPressed: () {},
// child: Text(
// '       Call       ',
// style: TextStyle(height: .06),
// ),
// )
// ],
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// SizedBox(height: 20),