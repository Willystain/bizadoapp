import 'package:flutter/material.dart';

import '../Services/city_service.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    bool toggle = false;

    if (currentFocus.hasPrimaryFocus == false) {
      toggle = true;
    }
    if (currentFocus.isFirstFocus == false) {
      toggle = false;
    }

    return Row(
      children: [
        Expanded(
          child: Autocomplete(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue == '') {
                return const Iterable<String>.empty();
              } else {
                return CityService.getSuggestions(textEditingValue.text);
              }
            },
            optionsViewBuilder:
                (context, Function(String) onSelected, options) {
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
              print(city);
              currentFocus.unfocus();
              print(currentFocus.hasPrimaryFocus);
            },
            optionsMaxHeight: 500,
            fieldViewBuilder:
                (context, controller, currentFocus, onEditingComplete) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextField(
                  controller: controller,
                  focusNode: currentFocus,
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                      suffixIcon: controller.value.text.isEmpty
                          ? Visibility(
                              child: Icon(Icons.abc),
                              visible: false,
                            )
                          : IconButton(
                              onPressed: () {
                                controller.clear();
                              },
                              icon: Icon(Icons.close)),
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      hintText: "Qual cidade?"),
                ),
              );
            },
          ),
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ElevatedButton(
              onPressed: () {
                currentFocus.unfocus();
              },
              child: Text("Voltar"),
            ),
          ),
          visible: toggle,
        ),
      ],
    );
  }
}
