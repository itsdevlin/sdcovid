require 'nokogiri'
require 'httparty'
require 'byebug'
require 'csv'

timestamp = Time.now.to_i
time_formatted = Time.now.strftime("%m/%d/%Y %k:%M")
url = "https://www.sandiegocounty.gov/content/sdc/hhsa/programs/phs/community_epidemiology/dc/2019-nCoV/status.html"
unparsed_page = HTTParty.get(url)
parsed_page = Nokogiri::HTML(unparsed_page)
full_table = parsed_page.css('div.table.parbase.section')
rows = full_table.css('tr') # get all rows (<tr>s)

text_all_rows = rows.map do |row|
  row_values = row.css('td').map(&:text) # get the text of each individual value (<td>)
  # I don't totally understand what this is doing, but text_all_rows is an array with the values as desired
end

text_all_rows.shift(1)

CSV.open("#{timestamp}.csv", "w") do |csv|
  csv << ["Data as of","#{time_formatted}"]
  text_all_rows.each {|row| csv << row } 
end

=begin
	
https://stackoverflow.com/questions/34781600/how-to-parse-a-html-table-with-nokogiri
https://ruby-doc.org/stdlib-2.7.1/libdoc/csv/rdoc/CSV.html
https://www.rubyguides.com/2015/12/ruby-time/
	
=end