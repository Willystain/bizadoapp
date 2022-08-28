import 'package:bizado/Pages/newPost_page.dart';
import 'package:bizado/Services/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../Services/city_service.dart';

class AutoCompleteField extends StatefulWidget {
  const AutoCompleteField({Key? key}) : super(key: key);

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GlobalVariables>(context);
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue == '') {
          return const Iterable<String>.empty();
        } else {
          return CityService.getSuggestions(textEditingValue.text);
        }
      },
      optionsViewBuilder: (context, Function(String) onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 4,
            child: SizedBox(
              width: 390,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemBuilder: ((context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    leading: Icon(Icons.location_city_sharp),
                    title: Text(option.toString()),
                    onTap: () {
                      onSelected(option.toString());
                    },
                  );
                }),
                itemCount: options.length,
              ),
            ),
          ),
        );
      },
      onSelected: (String city) {
        setState(() {
          controller.transform(city);
          controller.cityGlobal;
          print('chamou');
        });

        print(controller.cityGlobal);
      },
      optionsMaxHeight: 500,
    );
  }
}
