import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/view/details/details_screen.dart';
import 'package:flutter_application_1/viewmodel/apicallprovider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    super.key,
  });

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<ApiCallProvider>(context);
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   title: Padding(
      //     padding: const EdgeInsets.all(10),
      //     child: SizedBox(
      //       height: height / 17,
      //       width: width / .5,
      //       child: TextField(
      //         textAlignVertical: TextAlignVertical.bottom,
      //         onChanged: (value) {
      //           providerObj.searching(value);
      //         },
      //         decoration: InputDecoration(
      //           suffixIcon: Icon(
      //             Icons.search,
      //             color: Colors.grey,
      //           ),
      //           prefixIcon: IconButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               icon: Icon(Icons.arrow_back_rounded)),
      //           hintText: 'Search product',
      //           // hintStyle: TextStyle(color: Colors.grey),
      //           filled: true,
      //           fillColor: kSecondaryColor.withOpacity(0.1),
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(12),
      //             borderSide: BorderSide(color: Colors.white70),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 15,
            horizontal: MediaQuery.of(context).size.width / 20),
        child: Column(children: [
          Form(
            child: TextFormField(
              onChanged: (value) {
                providerObj.searching(value);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: kSecondaryColor.withOpacity(0.1),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: searchOutlineInputBorder,
                  focusedBorder: searchOutlineInputBorder,
                  enabledBorder: searchOutlineInputBorder,
                  hintText: "Search product",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: providerObj.myList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                product: providerObj.myList[index])));
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.network(
                              '${providerObj.myList[index].thumbnail}'),
                        ),
                        Expanded(
                          flex: 6,
                          child: ListTile(
                            title: Text('${providerObj.myList[index].title}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);
