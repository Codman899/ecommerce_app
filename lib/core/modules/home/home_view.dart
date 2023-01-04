import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecomerce_app/core/modules/auth/provider.dart';
import 'package:ecomerce_app/core/modules/home/widget/bottom_bar.dart';
import 'package:ecomerce_app/core/modules/home/widget/build_menu.dart';
import 'package:ecomerce_app/core/modules/home/widget/slider.dart';
import 'package:ecomerce_app/utils/replaced_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../../addon/action_text_button.dart';
import '../../../unplaced/floatingright.dart';
import '../../router/go_router.dart';
import '../products/products_list/products_grid.dart';
import '../products/products_list/products_search_text_field.dart';
import 'Custom_AppBar/more_menu.dart';
import 'Custom_AppBar/shopping_cart.dart';
import 'widget/text_widget.dart';

class HomeView extends ConsumerWidget {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();
    var screenSize = MediaQuery.of(context).size;
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final user = ref.watch(authStateChangesProvider).value;
      return Scaffold(
        appBar: AppBar(
          // centerTitle: false,
          // leading: IconButton(
          // icon: const Icon(
          // Icons.menu_rounded,
          ///color: Colors.white,
          // ),
          // onPressed: () {
          //   final state = _sideMenuKey.currentState;
          //   if (state!.isOpened) {
          //     state.closeSideMenu();
          //   } else {
          //     state.openSideMenu();
          //   }
          // },
          // ),
          // title: Text('My Shop'.hardcoded),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    // decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     border: Border.all(color: Colors.white),
                    //     borderRadius: BorderRadius.all(Radius.circular(8))),
                    margin: EdgeInsets.only(left: 12, bottom: 7),
                    //width: 350,
                    height: 46,
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: ProductsSearchTextField(),
                    )
                    // ProductsSearchTextField()),
                    ),
              ),
              Container(
                height: 46,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic,
                      size: 30,
                    )),
              )
            ],
          ),
        ),
        floatingActionButton: const FloatingMenu(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.white24,
                    child: SizedBox(
                      height: screenSize.height * 0.09,
                      width: screenSize.width,
                      // child: Image.asset(
                      //   'assets/images/cover.jpg',
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 20,
                    width: screenSize.width,
                    child: Center(
                      child: AnimatedTextKit(
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'Shop Now & Save Upto 40%',
                            textAlign: TextAlign.center,
                            textStyle: const TextStyle(
                                color: Color.fromARGB(167, 21, 185, 35),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: screenSize.height / 8,
                  //   width: screenSize.width,
                  //   child: const Center(
                  //     child: Text('Best Prices Guaranteed'),
                  //   ),
                  // ),
                ],
              ),
              BannerView(
                screenSize: screenSize,
              ),
              const ProductsSearchTextField(),
              // Hero(
              //   tag: 'search',
              //   child: Card(
              //     child: ListTile(
              //       title: FormBuilderTextField(
              //         name: "search",
              //         onChanged: (text) => ref
              //             .read(productsSearchQueryStateProvider.notifier)
              //             .state = text!,
              //         decoration: InputDecoration(
              //           hintText: "search",
              //           border: InputBorder.none,
              //           disabledBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //           focusedErrorBorder: InputBorder.none,
              //           filled: false,
              //           suffixIcon: value.text.isNotEmpty
              //               ? IconButton(
              //                   onPressed: () {
              //                     _controller.clear();
              //                     ref
              //                         .read(productsSearchQueryStateProvider
              //                             .notifier)
              //                         .state = '';
              //                   },
              //                   icon: const Icon(Icons.clear),
              //                 )
              //               : null,
              //         ),
              //         autofocus: false,
              //       ),
              //       trailing: const Icon(EvaIcons.search),
              //     ),
              //   ),
              // ),
              // const PriceSort(),
              buildCustom1Text(),
              const ProductsGrid(),
              BottomBar(),
            ],
          ),
        ),
      );
    });
  }
}
