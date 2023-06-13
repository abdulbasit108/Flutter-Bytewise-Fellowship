import 'package:flutter/material.dart';
import 'package:splendid_mart/common/widgets/loader.dart';
import 'package:splendid_mart/constants/global_variables.dart';
import 'package:splendid_mart/features/account/screens/all_orders.dart';
import 'package:splendid_mart/features/account/services/account_services.dart';
import 'package:splendid_mart/features/account/widgets/single_product.dart';
import 'package:splendid_mart/features/order_details/screens/order_details.dart';
import 'package:splendid_mart/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AllOrders.routeName);
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                height: 300,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 10,
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 5),
                  itemCount: 2,
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
          );
  }
}
