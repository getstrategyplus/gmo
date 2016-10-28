require 'test_helper'
require 'crawler/crawler'

module Crawler
  class NewsletterTest < ActiveSupport::TestCase

    def setup
      VCR.use_cassette('newsletter example 1') do
        @newsletter1 = Newsletter.new('http://static.getstrategyplus.com/2016/10/10/week-1-islamic-state-us-elections-north-korea')
        @newsletter1.reload
      end
      VCR.use_cassette('newsletter example 2') do
        @newsletter2 = Newsletter.new('http://static.getstrategyplus.com/2016/10/10/the-war-in-syria-sadly-continues')
        @newsletter2.reload
      end
    end
    
    test 'return correct title for example 1' do
      assert_equal 'Week #1: Islamic State, US Elections, North Korea', @newsletter1.title
    end

    test "return correct title for example 2" do
      assert_equal 'The war in Syria (sadly) continues', @newsletter2.title
    end 

    test 'return correct excerpt for example 1' do
      assert_equal %{Over the past weeks, several events unfolded with the Islamic State. The U.S. elections are also keeping a steady pace. And North Korea continues to defy the world. Today, we explore a series of editorials & opinions about these three situations.}, @newsletter1.excerpt
    end

    test "return correct excerpt for example 2" do
      assert_equal %{Today, we explore the events unfolding in Syria's civil war. America is losing influence as Turkey is getting closer ties with Russia. IS is retreating but the struggle remains, Mosul is not yet free and Aleppo is under a huge siege.}, @newsletter2.excerpt
    end

    test 'return correct sent_at for example 1' do
      assert_equal Date.new(2016, 10, 10), @newsletter1.sent_at
    end

    test "return correct sent_at for example 2" do
      assert_equal Date.new(2016, 10, 10), @newsletter2.sent_at
    end

    test 'return news with correct title for example 1' do
      news1 = @newsletter1.news.first
      assert_equal(%{The Mess Obama Left Behind in Iraq}, news1.title)
      
      news2 = @newsletter1.news.second
      assert_equal(%{Donald Trump Goes Low}, news2.title)
    end

    test 'return news with correct excerpt for example 1' do
      news1 = @newsletter1.news.first
      assert_equal(%{Is it right to blame the president for the rise of the Islamic State? Well, it’s not wrong.}, news1.excerpt)

      news2 = @newsletter1.news.second
      assert_equal(%{Donald Trump boiled his decadent campaign down to one theme during the presidential debate on Sunday night: hatred of Hillary and Bill Clinton.}, news2.excerpt)
    end

    test 'return news with correct image for example 1' do
      news1 = @newsletter1.news.first
      assert_equal('https://uploads.goodbits.io/uploads/link/thumbnail/3882426/gettyimages-450872170.jpg', news1.image)
      
      news2 = @newsletter1.news.second
      assert_equal('https://uploads.goodbits.io/uploads/link/thumbnail/3882424/10debateWeb-facebookJumbo.jpg', news2.image)
    end

    test 'return news with correct image alt for example 1' do
      news1 = @newsletter1.news.first
      assert_equal('The Mess Obama Left Behind in Iraq', news1.image_alt)

      news2 = @newsletter1.news.second
      assert_equal('Donald Trump Goes Low', news2.image_alt)
    end
  end
end