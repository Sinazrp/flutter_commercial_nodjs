import 'package:flutter/material.dart';

class AccountTopButton extends StatelessWidget {
  final String text;
  final VoidCallback func;
  const AccountTopButton({
    super.key,
    required this.text,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: InkWell(
        onTap: func,
        child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 237, 231, 231)),
            child: Center(
                child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))),
      ),
    );
  }
}

class ProductScroller extends StatelessWidget {
  const ProductScroller({
    super.key,
    required this.images,
  });

  final List images;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                    color: Colors.white, child: Image.network(images[index])),
              ),
            );
          },
          itemCount: images.length,
        ),
      ),
    );
  }
}