require 'rspec'
require "rake"
require_relative 'rakefile.rb'


RSpec.describe "scrape_image: To get all images from a web page", type: :rake do
  after(:each) do
    Rake::Task["scrape_image"].reenable
  end

  it "No url present" do
    expect do
      Rake::Task["scrape_image"].invoke()
    end.to output("Please provide web page url\n").to_stdout
  end
  it "With invalid url" do
    expect do
      Rake::Task["scrape_image"].invoke("hello")
    end.to output("ERROR: Invalid url\n").to_stdout
  end
  it "With valid url" do
    expect do
      Rake::Task["scrape_image"].invoke("https://www.google.com/")
    end.to output(a_string_including("Task successfull\n")).to_stdout
    Rake::Task["scrape_image"].reenable
    expect do
      Rake::Task["scrape_image"].invoke("https://www.google.com/")
    end.to output(a_string_including("google.com")).to_stdout
  end
end

