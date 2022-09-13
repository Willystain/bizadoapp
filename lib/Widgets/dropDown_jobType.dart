import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../Services/setup_riverPod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DropDownRiver extends ConsumerStatefulWidget {
  const DropDownRiver({Key? key}) : super(key: key);

  @override
  ConsumerState<DropDownRiver> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<DropDownRiver> {
  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>[
      'Todos',
      'Carpinteiro',
      'Limpeza',
      'Motorista',
    ];
    String dropdownValue = list.first;
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange, width: 0.8),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(10),
          value: ref.read(jobType),
          icon: const Icon(
            Icons.filter_list,
            color: Colors.deepOrange,
          ),
          elevation: 16,
          underline: SizedBox(),
          style: const TextStyle(color: Colors.deepOrange),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
              ref.read(jobType.notifier).state = value;
              ref.read(jobTypeNewPost.notifier).state = value;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
    );
  }
}
