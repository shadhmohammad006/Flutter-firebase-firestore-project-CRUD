import 'package:flutter/material.dart';
import 'package:flutter_application_1/model_class/model_Class.dart';
import 'package:flutter_application_1/model_class/widgets/Add_to_cart.dart';
import 'package:flutter_application_1/model_class/widgets/widgetpage.dart';
import 'package:flutter_application_1/model_class/widgets/wishlist.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<provider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final proProvider = Provider.of<provider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 170,
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'Mac Market',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 90,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WishList(),
                        ));
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const addCart(),
                        ));
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: 390,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    //  controller: searchController,
                    //onChanged: onSearchTextChanged,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: ' search item',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<provider>(
              builder: (context, api, child) {
                return api.products.isNotEmpty
                    ? GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: proProvider.products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WidgetPage(
                                    post: proProvider.products[index],
                                  ),
                                ),
                              );
                              print('Tapped on Item $index');
                            },
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Image.network(
                                          '${proProvider.products[index].thumbnail}',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: ListTile(
                                        title: Text(
                                          '${proProvider.products[index].title}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Column(
                                          children: [
                                            Text(
                                              '\$${proProvider.products[index].price}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                child: ListTile(
                                                  title: Text(
                                                    '${proProvider.products[index].rating}⭐',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            proProvider.toggleWishlist(index);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: proProvider
                                                    .products[index].inWishlist
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text("data"));
              },
            ),
          )
        ],
      ),
    );
  }
}
