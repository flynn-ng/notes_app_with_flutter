const String url = "http://127.0.0.1:8000/notes/";
Uri retrieveUrl = Uri.parse(url);

Uri createUrl = Uri.parse("${url}create/");

Uri deleteUrl(int id) => Uri.parse("$url$id/delete/");

Uri updateUrl(int id) => Uri.parse("$url$id/update/");
