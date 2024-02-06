
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/model_class.dart';
// import 'package:flutter_application_1/view/details/details_screen.dart';
// import 'package:flutter_application_1/viewmodel/apicallprovider.dart';
// import 'package:provider/provider.dart';



// class SearchList extends StatefulWidget {
//   const SearchList({super.key});

//   @override
//   State<SearchList> createState() => _SearchListState();
// }

// class _SearchListState extends State<SearchList> {
// //  Collections filter = Collections();
//   @override
//   Widget build(BuildContext context) {
//     final filter = Provider.of<ApiCallProvider>(context);

//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: filter.searchProducts(query).length,
//       itemBuilder: (context, index) {
//         final filters = filter.searchProducts(query)[index];
//         return GestureDetector(
//           onTap: () {
//             // collections.currentindex = index;
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //       builder: (context) => DetailPage(),
//             //     ));
//           },
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DetailsScreen(product: filters,
                       
//                         ),
//                   ));
//             },
//             child: ListTile(
//               title: Text(filter.searchProducts(query)[index].title),
//               subtitle: Text('\$${filter.searchProducts(query)[index].price}'),
//               leading: Container(
//                   height: 50,
//                   width: 50,
//                   child:
//                       Image.network(filter.searchProducts(query)[index].thumbnail)),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }