import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        //   backgroundColor: Colors.indigo,
        //   body: Column(
        //     children: [
        //       SizedBox(
        //         height: MediaQuery.of(context).size.height * 0.1,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 15),
        //         child: Container(
        //           width: double.infinity,
        //           height: 80.0,
        //           decoration: BoxDecoration(
        //               color: Colors.white.withOpacity(0.3),
        //               borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        //           child: ListTile(
        //             title: const Text(

        //                   'Ahmed Assem'
        //                  ,
        //               // widget.editDataModel.name!.isEmpty
        //               //     ? 'Ahmed Assem'
        //               //     : widget.editDataModel.name,
        //               style: TextStyle(
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.white),
        //             ),
        //             subtitle: const Text(

        //                   'ahmedasam300@gmial.com',
        //               style: TextStyle(color: Colors.white),
        //             ),
        //             trailing: Padding(
        //               padding: const EdgeInsets.only(
        //                 bottom: 20,
        //               ),
        //               child: SizedBox(
        //                 height: MediaQuery.of(context).size.height * 0.1,
        //                 width: MediaQuery.of(context).size.height * 0.1,
        //                 child: Align(
        //                   alignment: Alignment.topRight,
        //                   child: IconButton(
        //                       iconSize: 22,
        //                       color: Colors.white,
        //                       onPressed: () {
        //                         Navigator.of(context)
        //                             .push(MaterialPageRoute(builder: (context) {
        //                           return const EditProfileScreen();
        //                         }));
        //                       },
        //                       icon: const Icon(FontAwesomeIcons.edit)),
        //                 ),
        //               ),
        //             ),
        //             leading: CircleAvatar(
        //               radius: 27,
        //               child: Image.asset(

        //                       'assets/images/person.png'
        //                      ,
        //                   width: 45),
        //             ),
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 14,
        //       ),
        //       customNameBar(name: 'Email', context: context, onpress: () {}),
        //       customNameBar(name: 'Instgram', context: context, onpress: () {}),
        //       customNameBar(name: 'Twitter', context: context, onpress: () {}),
        //       customNameBar(name: 'Website', context: context, onpress: () {}),
        //       customNameBar(name: 'PayPal', context: context, onpress: () {}),
        //       customNameBar(
        //           name: 'Change Password', context: context, onpress: () {}),
        //       customNameBar(
        //           name: 'About i.click', context: context, onpress: () {}),
        //       customNameBar(
        //           name: 'Terms & Privacy', context: context, onpress: () {}),
        //       const SizedBox(
        //         height: 15,
        //       ),
        //       Row(
        //         children: [
        //           const SizedBox(
        //             width: 30,
        //           ),
        //           GestureDetector(
        //             onTap: () {
        //               setState(() {});
        //               SystemNavigator.pop();
        //             },
        //             child: Container(
        //               width: MediaQuery.of(context).size.width * 0.3,
        //               height: MediaQuery.of(context).size.height * 0.06,
        //               decoration: const BoxDecoration(
        //                   color: Colors.white,
        //                   borderRadius: BorderRadius.all(Radius.circular(25))),
        //               child: const Center(
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     Icon(
        //                       Icons.logout,
        //                       color: Colors.black,
        //                       size: 25.0,
        //                     ),
        //                     Text(
        //                       'Log out',
        //                       style: TextStyle(
        //                           fontSize: 16, fontWeight: FontWeight.bold),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           const Spacer(),
        //         ],
        //       )
        //     ],
        //   ),
        );
  }
}
