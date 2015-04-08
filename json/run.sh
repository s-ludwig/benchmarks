echo Crystal
../xtime.rb ./json_cr
echo Crystal Pull
../xtime.rb ./json_pull_cr
echo Crystal Schema
../xtime.rb ./json_schema_cr
echo Javascript Node
../xtime.rb nodejs test.js
echo Ruby
../xtime.rb ruby test.rb
echo Rust
../xtime.rb ./json_rs
echo Go
../xtime.rb ./json_go
echo D
../xtime.rb ./json_d
echo D Gdc
../xtime.rb ./json_d_gdc
echo D Ldc
../xtime.rb ./json_d_ldc
echo D new - debug
../xtime.rb ./json_d_new
echo D new Gdc - debug
../xtime.rb ./json_d_new_gdc
echo D new Ldc
../xtime.rb ./json_d_new_ldc
echo Nim
../xtime.rb ./json_nim
echo Python Pypy
../xtime.rb pypy test.py
echo Python
../xtime.rb python test.py
echo C++ Boost
../xtime.rb ./json_boost_cpp
echo C++ Rapid
../xtime.rb ./json_rapid_cpp
echo C++ LibJson
../xtime.rb ./json_libjson_cpp
echo Julia
../xtime.rb julia test.jl
echo Scala
../xtime.rb scala -J-Xmx3024m TestJson
