 import 'package:flutter/material.dart';

class ItemBottomSheet extends StatelessWidget {
   const ItemBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
         child: const Icon(Icons.open_in_new),
         onPressed: () {
           showModalBottomSheet(
             // isScrollControlled: true,
             context: context,
             builder: (context) {
               return Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: ListView.builder(
                   itemCount: 10,
                   itemBuilder: (BuildContext context, int index) {
                     return SizedBox(
                       width: double.infinity,
                       child: Column(
                         children: [
                           Row(
                             children: [
                               CircleAvatar(
                                 backgroundColor: Colors.white,
                                 radius: 35,
                                 child: Image.asset(
                                     'assets/images/person.png'),
                               ),
                               const SizedBox(width: 10),
                               const Text("Mohamed Hussein"),
                             ],
                           ),
                         ],
                       ),
                     );
                   },
                 ),
               );
             },
           );
         });
  }
}
