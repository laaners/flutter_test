//REST http call, add HTTP DEPENDECY!
import 'dart:convert'; //for json
import 'package:http/http.dart' as http;

//http://www.omdbapi.com/?apikey=b8c79639&s=Dune
//http://www.omdbapi.com/?apikey=b8c79639&i=tt0087182

const apiKey = "b8c79639";
const endpoint = "http://www.omdbapi.com/";

searchMovies(String query) async {
  //async, I will return a Promise
  if (query == "") {
    return [];
  }
  //async call, await done in a separated thread, the function LOGIC IS SYNCHRONOUS, BUT WHEN USED BEHAVES AS ASYNC
  var response = await http.get(Uri.parse("$endpoint?apikey=$apiKey&s=$query"));

  /*OR
  http.get(Uri.parse("$endpoint?apikey=$apiKey&s=$query")).then((res)=>{}).catch(()=>{})
  nested then can be hard to manage
  */
  final responseJson = json.decode(response.body);
  if (responseJson["Search"] != null) {
    //only those with poster, filter <-> where in dart, but does not return a list, convert it
    return responseJson["Search"]
        .where((movie) => movie["Poster"] != "N/A")
        .toList();
  }
  return [];
}

findMovie(String text) async {
  if (text == "") {
    return [];
  }

  var response =
      await http.get(Uri.parse(endpoint + "?apikey=" + apiKey + "&i=" + text));
  return json.decode(response.body);
}
