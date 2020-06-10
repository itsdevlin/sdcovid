require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
	url = "https://www.sandiegocounty.gov/content/sdc/hhsa/programs/phs/community_epidemiology/dc/2019-nCoV/status.html"
	unparsed_page = HTTParty.get(url)
	parsed_page = Nokogiri::HTML(unparsed_page)
	full_table = parsed_page.css('div.table.parbase.section')
	full_table.search('tr').each do |tr|
	cells = tr.search('th, td')
	puts cells.text
	end

	byebug


end

scraper

# div.table.parbase.section


=begin
	


(byebug) full_table = parsed_page.css('div.table.parbase.section')

full_table.css('td').first
// full first row of everything

full_table.css('tr').first.text
// text strings of the first row

full_table.css('tr')[0]
// first row 

	


full_table.search('tr').each do |tr|
	cells = tr.search('th, td')
end

=end