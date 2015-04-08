if [ ! -f 1.json ]; then
  ruby generate_json.rb
fi

if [ ! -d std_data_json ]; then
    git clone https://github.com/s-ludwig/std_data_json.git
else
    git -C std_data_json fetch
fi

crystal build test.cr --release -o json_cr
crystal build test_pull.cr --release -o json_pull_cr
crystal build test_schema.cr --release -o json_schema_cr
cargo build --manifest-path json.rs/Cargo.toml --release && cp ./json.rs/target/release/json ./json_rs

#std.json
dmd -ofjson_d -O -release -inline test.d
gdc -o json_d_gdc -O3 -frelease -finline test.d
ldc2 -ofjson_d_ldc -O5 -release -inline test.d

#std_data_json
#dmd -ofjson_d_new -O -release -inline -w -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new.d
dmd -ofjson_d_new -debug -g -w -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new.d
#gdc -o json_d_new_gdc -frelease -finline-functions -O3 -Werror -Wall -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new.d
gdc -o json_d_new_gdc -fdebug -g -Werror -Wall -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new.d
ldc2 -ofjson_d_new_ldc -O5 -release -enable-inlining -w -oq -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new.d

#std_data_json streamed
#dmd -ofjson_d_new_lazy -O -release -inline -w -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new_lazy.d
dmd -ofjson_d_new_lazy -debug -g -w -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new_lazy.d
#gdc -o json_d_new_lazy_gdc -frelease -finline-functions -O3 -Werror -Wall -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new.d
gdc -o json_d_new_lazy_gdc -fdebug -g -Werror -Wall -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new_lazy.d
ldc2 -ofjson_d_new_lazy_ldc -O5 -release -enable-inlining -w -oq -Istd_data_json/source/ std_data_json/source/stdx/data/json/foundation.d std_data_json/source/stdx/data/json/generator.d std_data_json/source/stdx/data/json/lexer.d std_data_json/source/stdx/data/json/package.d std_data_json/source/stdx/data/json/parser.d std_data_json/source/stdx/data/json/value.d test_new_lazy.d

nim c -o:json_nim -d:release --cc:clang --verbosity:0 test.nim
scalac -optimize test.scala
go build -o json_go test.go
g++ -O3 test_boost.cpp -o json_boost_cpp

if [ ! -d rapidjson ]; then
  git clone --depth 1 https://github.com/miloyip/rapidjson.git
fi
g++ -O3 test_rapid.cpp -o json_rapid_cpp -Irapidjson/include
g++ -O3 test_libjson.cpp -o json_libjson_cpp -ljson
julia -e 'Pkg.add("JSON")'
