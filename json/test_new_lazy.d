import std.exception;
import std.file;
import std.stdio;

import stdx.data.json;

int main(string[] args) {
  string text = cast(string)read("./1.json"); // don't UTF-validate to match RapidJSON
  auto nodes = parseJSONStream!(LexOptions.noThrow|LexOptions.noTrackLocation)(text);
  double x = 0;
  double y = 0;
  double z = 0;
  size_t len = 0;
  
  enforce(nodes.skipToKey("coordinates"));

  nodes.readArray({
    len++;
    nodes.readObject((key) {
      switch (key) {
        default: nodes.skipValue(); break;
        case "x": x += nodes.readDouble(); break;
        case "y": y += nodes.readDouble(); break;
        case "z": z += nodes.readDouble(); break;
      }
    });
  });

  printf("%.8f\n%.8f\n%.8f\n", x / len, y / len, z / len);
  return 0;
}
