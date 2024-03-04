import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/models/product.dart';
import 'package:shop_flutter_app/providers/product_list.dart';
import 'package:shop_flutter_app/routes.dart';

class ProductItem extends StatefulWidget {
  Product product;
  ProductItem(this.product, {super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.product.imageUrl),
      ),
      title: Text(widget.product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(
                    Routes.productForm,
                    arguments: widget.product,
                  )
                  .then(
                    (product) => setState(() => setState(() {
                          widget.product = product as Product;
                        })),
                  ),
              icon: const Icon(Icons.edit),
              color: const Color.fromARGB(255, 209, 209, 17),
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Tem certeza?'),
                    content: const Text('Quer remover o item do carrinho?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text(
                          'Não',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ProductList>(context, listen: false)
                              .removeProduct(widget.product);
                          Navigator.of(ctx).pop();
                        },
                        child: const Text(
                          'Sim',
                        ),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
