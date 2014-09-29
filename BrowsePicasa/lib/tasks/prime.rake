require 'prime'

desc 'returns biggest prime factor of a number'
task :biggest_prime_factor_of do
  number = ENV['NUM']
  biggest_prime_factor = number.to_i.prime_division.transpose.shift.last
  puts "Biggest prime factor of #{number} is #{biggest_prime_factor}"
end