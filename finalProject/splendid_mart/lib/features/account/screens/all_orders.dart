import 'package:flutter/material.dart';
import 'package:splendid_mart/common/widgets/loader.dart';
import 'package:splendid_mart/constants/global_variables.dart';
import 'package:splendid_mart/features/account/services/account_services.dart';
import 'package:splendid_mart/features/account/widgets/single_product.dart';
import 'package:splendid_mart/features/order_details/screens/order_details.dart';
import 'package:splendid_mart/models/order.dart';

class AllOrders extends StatefulWidget {
  static const String routeName = '/all-orders';
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _OrdersState();
}

class _OrdersState extends State<AllOrders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Icon(
                        Icons.search,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: orders == null
            ? const Loader()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        child: const Text(
                          'Your Orders',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // display orders
                  Container(
                    height: 500,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 20,
                      right: 10,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 5),
                      itemCount: orders!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OrderDetailScreen.routeName,
                              arguments: orders![index],
                            );
                          },
                          child: SingleProduct(
                            image: orders![index].products[0].images[0],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
  }
}
