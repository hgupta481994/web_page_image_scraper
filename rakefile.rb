require 'nokogiri'
require 'open-uri'

desc "Scrape images from web page"
task :scrape_image, [:url] do |t, args|
  url = args[:url]
  # Check if url is present in arguments
  if url 
  	uri = URI.parse(url)
  	# Check if URL is valid or not
  	if uri.is_a?(URI::HTTP) && !uri.host.nil?

  		# Get web page 
			doc = Nokogiri::HTML(open(url))
			# Delete already existing images folder if exists
			FileUtils.rm_rf("images/") if  File.exist?("images/")
			Dir.mkdir "images" unless File.exist? "images"
			# Save all images in images folder
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
