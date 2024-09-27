import os
import scrapy

class xyx(scrapy.Spider):
    name = "xyz"
    start_urls = ['']

    def parse(self, response):
        # Save the current page as an HTML file
        page_path = response.url.split('')[-1]
        if page_path == '':
            page_path = 'index.html'
        else:
            page_path = f"{page_path.rstrip('/')}.html"
        self.save_page(response.body, page_path)

        # Follow links to other pages
        for next_page in response.css('a::attr(href)').getall():
            if next_page.startswith('/'):
                yield response.follow(next_page, self.parse)

    def save_page(self, body, path):
        # Ensure the directory exists
        directory = os.path.dirname(path)
        if directory and not os.path.exists(directory):
            os.makedirs(directory, exist_ok=True)
        
        # Save the content to the file
        with open(path, 'wb') as f:
            f.write(body)