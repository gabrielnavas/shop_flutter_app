import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/models/product.dart';
import 'package:shop_flutter_app/models/product_list.dart';
import 'package:shop_flutter_app/routes.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController _imageUrlController = TextEditingController();
  final _nameFocus = FocusNode();
  final _descriptionUrlFocus = FocusNode();
  final _priceUrlFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Product product = Product.init();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _descriptionUrlFocus.dispose();
    _priceUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    // it's update the _imageUrlController, because if
    // _imageUrlController.text is empty, need show image to text
    // and it's update the UI
    setState(() {});
  }

  bool _verifyForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return false;
    }

    _formKey.currentState?.save();
    return true;
  }

  void _submitForm() {
    if (!_verifyForm()) {
      return;
    }

    Provider.of<ProductList>(context, listen: false).addProduct(product);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
        actions: [
          IconButton(
            onPressed: () => _submitForm(),
            icon: const Icon(
              Icons.save,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  decoration: const InputDecoration(label: Text('Nome')),
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  validator: (value) => Product.validName(value ?? ''),
                  onChanged: (value) => _verifyForm(),
                  onSaved: (name) {
                    if (name != null && name.isNotEmpty) {
                      product.name = name;
                    }
                  }),
              TextFormField(
                  decoration: const InputDecoration(label: Text('Preço')),
                  focusNode: _priceUrlFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) => _verifyForm(),
                  validator: (value) => Product.validPrice(
                      double.tryParse(value?.trim() ?? '-1') ?? -1),
                  onSaved: (price) {
                    if (price != null && price.isNotEmpty) {
                      product.price = double.parse(price);
                    }
                  }),
              TextFormField(
                  decoration: const InputDecoration(label: Text('Descrição')),
                  focusNode: _descriptionUrlFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  validator: (value) => Product.validDescription(value ?? ''),
                  onChanged: (value) => _verifyForm(),
                  onSaved: (description) {
                    if (description != null && description.isNotEmpty) {
                      product.description = description;
                    }
                  }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Url da imagem')),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocus,
                        onFieldSubmitted: (value) => _submitForm(),
                        validator: (value) =>
                            Product.validImageUrl(value ?? ''),
                        onChanged: (value) => _verifyForm(),
                        onSaved: (imageUrl) {
                          if (imageUrl != null && imageUrl.isNotEmpty) {
                            product.imageUrl = imageUrl;
                          }
                        }),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(136, 130, 130, 130),
                          width: 1),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('informe a url')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
