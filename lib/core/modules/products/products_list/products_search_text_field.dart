import 'package:ecomerce_app/utils/replaced_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'products_search_state_provider.dart';

/// Search field used to filter products by name
class ProductsSearchTextField extends ConsumerStatefulWidget {
  const ProductsSearchTextField({super.key});

  @override
  ConsumerState<ProductsSearchTextField> createState() =>
      _ProductsSearchTextFieldState();
}

class _ProductsSearchTextFieldState
    extends ConsumerState<ProductsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextFormField(
          //textAlign: TextAlign.center,
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search),
            hintText: 'Search products'.hardcoded,
            //icon: const Icon(Icons.search),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      ref
                          .read(productsSearchQueryStateProvider.notifier)
                          .state = '';
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onChanged: (text) =>
              ref.read(productsSearchQueryStateProvider.notifier).state = text,
        );
      },
    );
  }
}
