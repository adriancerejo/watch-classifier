# libraries needed for web scraping
require 'watir'
require 'nokogiri'

# different brands to scrape
watch_brands = [
    'armani',
    'audemarspiguet',
    'breitling',
    'cartier',
    'fossil',
    'gucci',
    'guess',
    'iwc',
    'jaegerlecoultre',
    'michaelkores',
    'movado',
    'omega',
    'panerai',
    'patekphilippe',
    'rolex',
    'seiko',
    'zenith'
]

# browser instance
chrome_browser = Watir::Browser.new(chrome)

# first 5 pages of chrono24 will be scraped per brand
watch_brands.each do |brand|
    pages = [
    'http://chrono24.com/#{brand}/index.htm',
    'http://chrono24.com/#{brand}/index-2.htm',
    'http://chrono24.com/#{brand}/index-3.htm',
    'http://chrono24.com/#{brand}/index-4.htm',
    'http://chrono24.com/#{brand}/index-5.htm'
    ]

    # for each page, visit the website and scroll down halfway to load in paginated images
    pages.each do |page|
        chrome_browser.goto(url)
        10.times do |x|
            chrome_browser.execute_script("window.scrollBy(0,750)")
        end

    # grab the page as html
    html_page = Nokogiri::HTML.parse(chrome_browser.html)

    # access all the images which are kept in divs with the className of article-item-container
    article_item_container = html_page.css(".article-item-container")
    # for every container access the elements that contain the image
    article_item_container.do |article_item|
        image = article_item.at_css(".article-image-container .content img")
        # store the image url
        image_url = image['src']

        #open the dataset file and write the image url to a text file 
        File.open("dataset/#{brand}.txt", "a+") do |file|
            file.puts("#{image_url}")
        end
    end
end
