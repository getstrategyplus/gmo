require 'test_helper'
require 'crawler/crawler'

module Crawler
  class ArchiveTest < ActiveSupport::TestCase
    test "return all newsletters with correct address_url" do
      VCR.use_cassette('goodbit_archive_page') do

        archive = Crawler::Archive.new

        assert_equal 'http://static.getstrategyplus.com/2016/10/10/week-1-islamic-state-us-elections-north-korea', archive.newsletters.first.address_url
        assert_equal 'http://static.getstrategyplus.com/2016/10/10/the-war-in-syria-sadly-continues', archive.newsletters.last.address_url
      end
    end
  end
end