require 'watir'
require 'nokogiri'

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

chrome_browser = Watir::Browser.new(chrome)

watch_brands.each do |brand|
    pages = [
    'http://chrono24.com/#{brand}/index.htm',
    'http://chrono24.com/#{brand}/index-2.htm',
    'http://chrono24.com/#{brand}/index-3.htm',
    'http://chrono24.com/#{brand}/index-4.htm',
    'http://chrono24.com/#{brand}/index-5.htm'
    ]

    pages.each do |page|
        chrome_browser.goto(url)
        20.times do |x|
            chrome_browser.execute_script("window.scrollBy(0,800)")
    end

    html_page = Nokogiri::HTML.parse(chrome_browser.html)

    article_item_container = html_page.css(".article-item-container")
    article_item_container.do |article_item|
        image = article_item.at_css(".article-image-container .content img")

        price = article_item.at_css(".article-price strong").text
        
        image_url = image['src']
        priceNum = price.gsub(/[^0-9]/, "")

        File.open("dataset/#{brand}.txt", "a+") do |file|
            file.puts("#{image_url},#{priceNum}")
        end
    end
end
