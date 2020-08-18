hash_1 = {}
main = {}
arr = %i[mm ll ee]
arr1 = %w[ff hh pp]
arr2 = %w[ffd hah p2p]

arr.length.times do |i|
  hash_1[arr[i]] = {}
  arr.length.times do |j|
    hash_1[arr[i]].merge!({ arr1[j] => arr2[j] })
  end
end
main.merge!(hash_1)

p main
