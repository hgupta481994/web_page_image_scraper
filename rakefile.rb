require 'nokogiri'
require 'open-uri'

desc "Scrape images from web page"
task :scrape_image, [:url] do |t, args|
  url = args[:url]
  if url 
  	uri = URI.parse(url)
  	if uri.is_a?(URI::HTTP) && !uri.host.nil?
			doc = Nokogiri::HTML(open(url))

			FileUtils.rm_rf("images/") if  File.exist?("images/")
			Dir.mkdir "images" unless File.exist? "images"
			doc.css('img').each do |el|
				if el.attributes["src"]
					link = URI.join(url, el.attributes["src"].value).to_s
					puts link
					File.open("images/#{File.basename(link)}",'wb'){|f| f << open(link,'rb').read}
				end
			end
			puts "Task successfull"
		else
			puts "ERROR: Invalid url"
		end
	else
		puts "Please provide web page url"
	end
end
