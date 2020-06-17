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

rows_clean = text_all_rows.drop(1)

byebug

CSV.open("#{timestamp}.csv", "w") do |csv|
  csv << ["Data as of","#{time_formatted}"]
  rows_clean.each {|row| csv << row } 
end

=begin
	
Get numeric value for specific row
total_positive = rows_clean[1].last.gsub(",","").to_i # ex 6/13: "9,314" -> "9314"
age_group_1 = rows_clean[3].last.gsub(",","").to_i # ex 6/13: "196" -> "196"

Solid quickstart for sheets
https://www.twilio.com/blog/2017/03/google-spreadsheets-ruby.html

Sheets api docs
https://developers.google.com/sheets/api/samples/writing
https://developers.google.com/sheets/api/samples/reading

Twilio send sms docs
https://www.twilio.com/docs/sms/services/tutorials/how-to-send-sms-messages-services-ruby

https://stackoverflow.com/questions/34781600/how-to-parse-a-html-table-with-nokogiri
https://ruby-doc.org/stdlib-2.7.1/libdoc/csv/rdoc/CSV.html
https://www.rubyguides.com/2015/12/ruby-time/
	
=end