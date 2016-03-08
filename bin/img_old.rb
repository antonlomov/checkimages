require 'csv'
require "net/http"
require "uri"

start_time = Time.now
def check(url)
  uri = URI(url)
  res = Net::HTTP.get_response(uri)
  res.code
end

result = []
array_of_data = CSV.read('sourcefiles/sourcefile.csv', headers:false, col_sep:';')


 array_of_data.each do |url|
  if check(url[0]) == '404'
    result << [url[1], url[2]]
  end
end

puts "Pocet chyb obrazkov: #{result.length}"
result.each {|item| puts "#{item[1]} - #{item[0]}"}
end_time = Time.now
puts "Time: #{end_time - start_time}"
