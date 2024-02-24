import 'package:flutter/material.dart';
import 'package:social_app/views/screens/storoes_screen/perecent_progress_bar.dart';
import 'package:social_app/views/screens/storoes_screen/widgets/show_botton_sheet.dart';

class StoryProgressBar extends StatelessWidget {
 final List<double> precentValue;
  const StoryProgressBar({required this.precentValue, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: MyPresentProgressBar(
                precentValue: precentValue[0],
              )),
              Expanded(
                  child: MyPresentProgressBar(
                precentValue: precentValue[1],
              )),
              Expanded(
                  child: MyPresentProgressBar(
                precentValue: precentValue[2],
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: Image.asset('assets/images/person.png'),
              ),
              const SizedBox(width: 10),
              const Text("Mohamed Hussein"),
              const SizedBox(width: 5),
              const Text("10m"),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.cancel_outlined)),
            ],
          ),
          const Spacer(),
          const ItemBottomSheet(),
        ],
      ),
    );
  }
}
