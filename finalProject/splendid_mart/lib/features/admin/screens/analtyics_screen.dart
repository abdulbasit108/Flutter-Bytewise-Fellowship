// import 'package:fl_chart/fl_chart.dart' as charts;
// import 'package:flutter/material.dart';
// import 'package:splendid_mart/common/widgets/loader.dart';
// import 'package:splendid_mart/features/admin/models/sales.dart';
// import 'package:splendid_mart/features/admin/services/admin_services.dart';
// import 'package:splendid_mart/features/admin/widgets/category_products_chart.dart';

// class AnalyticsScreen extends StatefulWidget {
//   const AnalyticsScreen({Key? key}) : super(key: key);

//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen> {
//   final AdminServices adminServices = AdminServices();
//   int? totalSales;
//   List<Sales>? earnings;

//   @override
//   void initState() {
//     super.initState();
//     getEarnings();
//   }

//   getEarnings() async {
//     var earningData = await adminServices.getEarnings(context);
//     totalSales = earningData['totalEarnings'];
//     earnings = earningData['sales'];
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return earnings == null || totalSales == null
//         ? const Loader()
//         : Column(
//             children: [
//               Text(
//                 '\$$totalSales',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 250,
//                 child: CategoryProductsChart(seriesList: [
//                   charts.
//                   Series(
//                     id: 'Sales',
//                     data: earnings!,
//                     domainFn: (Sales sales, _) => sales.label,
//                     measureFn: (Sales sales, _) => sales.earning,
//                   ),
//                 ]),
//               )
//             ],
//           );
//   }
// }
