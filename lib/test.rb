# require 'json'
# hash1 = { first_person: { ber: 'ber', ket: 'ket' } }
# bash = {}
# hash2 = { ber: 'beqqr', ket: 'qqket' }

# arr = JSON.parse(File.read("test.json"))
# arr << hash
#
# filename = 'test.json'

# hash = { sec_person: { 'first_name' => 'john', 'last_name' => 'doe' } }

# array = JSON.parse(File.read(filename))
# array << hash

# JSON.parse(json, :quirks_mode => true)
# bash.merge!(hash1)
# bash.merge!(hash)
# p bash

# File.write("test.json", JSON.dump(hash1))
# if File.read("test.json") != ''
#   file = JSON.parse(File.read("test.json"))
#   file.merge!(hash)
#   File.write("test.json", JSON.dump(file))
# else
#   File.write("test.json", JSON.dump(hash1))
# end

# p file = JSON.parse(File.read("test.json"))

# p hash2[:ber]
