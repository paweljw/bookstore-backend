# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

GOODREADS_URL = 'http://www.goodreads.com/list/show/643.Guilty_Pleasures_Crap_You_re_Embarrassed_to_Love'.freeze

namespace :import do
  task goodreads: :environment do
    doc = Nokogiri::HTML(open(GOODREADS_URL))

    books = doc.xpath('//*[@itemtype="http://schema.org/Book"]')

    books.each { |book| book_from_xml(book) }
  end

  def book_from_xml(book)
    title, author_name = book.xpath('.//*[@itemprop="name"]').map(&:content)
    author = Author.find_or_create_by(name: author_name)

    book = create_book(author, title)

    puts "#{book.author} - #{book} for #{book.price}"
  end

  def create_book(author, title)
    book = author.books.find_or_create_by(title: title)
    book.price ||= rand * 15
    book.save
    book
  end
end
