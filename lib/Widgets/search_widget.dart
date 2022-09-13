import 'package:bizado/Pages/feed_page.dart';
import 'package:bizado/Services/post_service.dart';
import 'package:bizado/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Services/setup_riverPod.dart';

import '../Services/city_service.dart';

class SearchBar extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
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
              //CHAMAR LISTA FILTRADA
              setState(() {
                ref.watch(cityProvider.notifier).state = city;
              });

              currentFocus.unfocus();
            },
            optionsMaxHeight: 500,
            fieldViewBuilder:
                (context, controller, currentFocusText, onEditingComplete) {
              if (ref.watch(cityProvider.notifier).state.length < 1) {
                controller.clear();
              }
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextField(
                        controller: controller,
                        focusNode: currentFocusText,
                        onEditingComplete: onEditingComplete,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Visibility(
                              visible: ref.watch(cityProvider).length > 1,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ref.read(cityProvider.notifier).state = '';
                                  });
                                },
                                icon: Icon(Icons.close),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide:
                                  BorderSide(color: Colors.deepOrange[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide:
                                  BorderSide(color: Colors.deepOrange[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide:
                                  BorderSide(color: Colors.deepOrange[300]!),
                            ),
                            hintText: "Cidade"),
                      ),
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
                    visible: currentFocusText.hasFocus,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
