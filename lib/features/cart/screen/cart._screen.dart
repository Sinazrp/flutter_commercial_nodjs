import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercial_nodjs/features/cart/widget/cart_list.dart';
import 'package:flutter_commercial_nodjs/features/home/home_widgets.dart';
import 'package:flutter_commercial_nodjs/model/product.dart';

import '../../../logic/bloc_user/user_bloc.dart';
import '../services/services.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    double totalDiscount = 0;
    double totalPriceWithDiscount = 0;
    void calculateTotal(UserState state) {
      totalPrice = 0; //clear the value of totalPrice before calculating
      for (var i = 0; i < state.user.cart.length; i++) {
        var price = state.user.cart[i]['product']['price'];
        // debugPrint(price.toString());

        totalPrice += price * state.user.cart[i]['quantity'];
        totalDiscount += price *
            state.user.cart[i]['quantity'] *
            0.1; //change here to calculate the discount based on the price and quantity
      }
      totalPriceWithDiscount = totalPrice - totalDiscount;
    }

    Future<bool> checkValidation(UserState state) async {
      List<bool> validationList = [];

      for (var i = 0; i < state.user.cart.length; i++) {
        Product product = Product.fromMap(state.user.cart[i]['product']);
        bool a =
            await CartServices().checkItemValidation(id: product.id.toString());
        validationList.add(a);
      }

      if (validationList.contains(false)) {
        return false;
      }
      return true;
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        checkValidation(state);
        calculateTotal(state);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Shopping Cart'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AdressBar(state: state),
                CartList(
                  state: state,
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.data == false) {
                      return const Text('validation is working');
                    }
                    return const SizedBox();
                  },
                  future: checkValidation(state),
                )
              ],
            ),
          ),

          /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AdressBar(state: state),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    //TODO : should get product from product api -- not user api do this by matching id
                    child: ListView.separated(
                      itemCount: state.user.cart.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 16.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(state.user.cart[index]
                                    ['product']['images'][0]),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user.cart[index]['product']['name'],
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '\$${state.user.cart[index]['product']['price']}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (state.user.cart[index]
                                                    ['quantity'] >
                                                1) {
                                              state.user.cart[index]
                                                  ['quantity']--;
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text(
                                          '${state.user.cart[index]['quantity']}'),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            state.user.cart[index]
                                                ['quantity']++;
                                          });
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      const SizedBox(width: 8.0),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            state.user.cart[index]['quantity'];
                                          });
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        textAlign: TextAlign.right,
                        'قیمت محصولات: ${totalPrice.toStringAsFixed(0)} تومان ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        textAlign: TextAlign.right,
                        'تخفیف: ${totalDiscount.toStringAsFixed(0)} تومان ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        textAlign: TextAlign.right,
                        'قیمت نهایی: ${totalPriceWithDiscount.toStringAsFixed(0)} تومان ',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'خریدت رو نهایی کن',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ), */
          bottomNavigationBar: BottomAppBar(
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text.rich(TextSpan(
                        children: [
                          TextSpan(text: ' جمع کل'),
                        ],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                    Text(' ${totalPrice.round()} ')
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  width: 120,
                  height: MediaQuery.of(context).size.height * 0.055,
                  child: Center(
                      child: InkWell(
                    onTap: () {},
                    child: const Text(
                      'تکمیل خرید',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
