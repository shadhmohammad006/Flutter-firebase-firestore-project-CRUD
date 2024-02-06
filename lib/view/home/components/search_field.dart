import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/products/products_screen.dart';
import 'package:flutter_application_1/view/search/search.dart';
import 'package:flutter_application_1/viewmodel/searchprovider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 22,
          ),
          Text(
            'Search product',
            style: TextStyle(),
          )
        ]),
      ),
    );
    // return Form(
    //   child: TextFormField(
    //     onChanged: (value) {},
    //     decoration: InputDecoration(
    //       filled: true,
    //       fillColor: kSecondaryColor.withOpacity(0.1),
    //       contentPadding:
    //           const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //       border: searchOutlineInputBorder,
    //       focusedBorder: searchOutlineInputBorder,
    //       enabledBorder: searchOutlineInputBorder,
    //       hintText: "Search product",
    //       prefixIcon: const Icon(Icons.search),
    //     ),
    //   ),
    // );
  }
}

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

// class SearchScreen extends StatelessWidget {
//   SearchScreen({
//     super.key,
//   });

//   var size, height, width;

//   @override
//   Widget build(BuildContext context) {
//     final providerObj = Provider.of<SearchProvider>(context);
//     size = MediaQuery.of(context).size;
//     height = size.height;
//     width = size.width;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.grey,
//         title: Padding(
//           padding: const EdgeInsets.all(10),
//           child: SizedBox(
//             height: height / 17,
//             width: width / .5,
//             child: TextField(
//               textAlignVertical: TextAlignVertical.bottom,
//               onChanged: (value) {
//                 providerObj.searching(value);
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Icon(Icons.search),
//                 prefixIcon: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back_rounded)),
//                 hintText: 'Search',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(13),
//                   borderSide: BorderSide(color: Colors.white70),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Column(children: [
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: providerObj.myList.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ProductsScreen(
//                               product: providerObj.myList[index])));
//                 },
//                 child: Card(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Image.network(
//                             '${providerObj.myList[index].thumbnail}'),
//                       ),
//                       Expanded(
//                         flex: 6,
//                         child: ListTile(
//                           title: Text('${providerObj.myList[index].title}'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         )
//       ]),
//     );
//   }
// }
