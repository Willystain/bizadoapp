


// // TypeAheadField<String>(
//           suggestionsBoxDecoration: SuggestionsBoxDecoration(),
//           getImmediateSuggestions: true,
//           textFieldConfiguration: TextFieldConfiguration(
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'What are you looking for?'),
//           ),
//           suggestionsCallback: (String pattern) {
//             return CityService.getSuggestions(pattern);
//           },
//           itemBuilder: (context, String suggestion) {
//             return ListTile(
//               title: Text(suggestion),
//             );
//           },
//           onSuggestionSelected: (String suggestion) {
//             print("Suggestion selected");
//           },
//         ),