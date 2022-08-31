import 'package:ecommerce/app/pages/product/product_details.dart';
import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/extensions/string_ext.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDisplay extends ConsumerWidget {
  const ProductDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Product>>(
        stream: ref.read(databaseProvider)!.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return const EmptyWidget();
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Hero(
                                    tag: product.name,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(product.imageUrl),
                                    ))),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              product.name.capitalize(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "\$${product.price}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
