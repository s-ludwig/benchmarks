import std.stdio;
import std.file;
import std.algorithm;

import stdx.data.json;

int main(string[] args) {
  string text = readText("./1.json");
  auto nodes = parseJSONStream(text);
  double x = 0;
  double y = 0;
  double z = 0;
  size_t len = 0;
  int state = 0;

  foreach (nd; nodes) {
    if(nd.kind == JSONParserNode.Kind.key && nd.key == "x")
    {
      state = 0;
      ++len;
    }
    else if(nd.kind == JSONParserNode.Kind.literal && state < 3)
    {
      double val = nd.literal.number.doubleValue;
      if(state == 0) x += val;
      else if(state == 1) y += val;
      else z += val;
      ++state;
    }
  }

  printf("%.8f\n%.8f\n%.8f\n", x / len, y / len, z / len);
  return 0;
}
