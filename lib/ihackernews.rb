require 'net/http'
require 'json'

class Ihackernews
  def initialize
    @url = URI.parse('http://api.ihackernews.com/page')
    @items = []
  end

  def items
    @items
  end

  def points
    @items.collect { |item| item['points'].to_i }
  end

  def fetch
    req = Net::HTTP::Get.new(@url.path)
    res = Net::HTTP.start(@url.host, @url.port) { |http|
      http.request(req)
    }
    json = JSON.parse(res.body)

    @items = json['items']
  end

  def hotnews
    @items.select { |item| item['points'] > median }
  end

  def median
    sorted = self.points.sort
    len = @items.count

    if len % 2 == 1 then
      sorted[len/2]
    else
      (sorted[len/2 - 1] + sorted[len/2]).to_f / 2
    end
  end

  def mean
    total = self.points.inject { |sum, item| sum + item }

    total / @items.count
  end

  def mode
    self.points.group_by do |e|
      e
    end.values.max_by(&:size).first

    points = self.points.group_by { |e| e }
    points.values.max_by(&:size).first
  end

  def print
    @items.each { |item|
      puts item['title']
      puts item['url']
      puts "Points: #{item['points']}"
      puts
    }
  end

end

require 'ihackernews/mail'
