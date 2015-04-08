import std.stdio;
import std.file;
import std.conv;

import stdx.data.json;

int main(string[] args) {
  string text = readText("./1.json");
  auto jval = parseJSONValue(text);
  assert(!text.length);
  auto coordinates = jval.get!(JSONValue[string])["coordinates"].get!(JSONValue[]);
  double x = 0;
  double y = 0;
  double z = 0;

  foreach (val; coordinates) {
    x += val.opt("x").coerce!double;
    y += val.opt("y").coerce!double;
    z += val.opt("z").coerce!double;
  }

  printf("%.8f\n%.8f\n%.8f\n", x / coordinates.length, y / coordinates.length, z / coordinates.length);
  return 0;
}
