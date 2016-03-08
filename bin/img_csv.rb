require 'csv'
require "net/http"
require "uri"

start_time = Time.now
def check(url)
  uri = URI(url)
  res = Net::HTTP.get_response(uri)
  res.code
end

result = 0
pictures = 0
array_of_data = CSV.read('sourcefiles/sourcefile.csv', headers:false, col_sep:';')

# File.open('missing_images_new.txt','w') { |f|
#   array_of_data.each do |url|
#     if check(url[0]) == '404'
#       f.puts "#{url[2]}, #{url[1]}"
#       result += 1
#     end
#     pictures += 1
#   end
# }

# def export_csv(array_of_data)
  CSV.open('missing_images.csv', 'w', { :encoding => 'utf-8', :col_sep => ';' }) do |csv_object|
    array_of_data.each do |url|
      if check(url[0]) == '404'
        csv_object << url
        result += 1
      end
      pictures += 1
    end
  end
  puts "CSV finished"
  # puts ""
# end

# export_csv(array_of_data)
puts "Celk pocet obrazkov: #{pictures}"
puts "Pocet chyb obrazkov: #{result}"
end_time = Time.now
puts "Time: #{end_time - start_time}"
