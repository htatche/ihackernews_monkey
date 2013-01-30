#!ruby19
# encoding: utf-8
require 'net/smtp'

class Ihackernews::Mail
  def initialize(server, port, username, password, from)
    @server   = server
    @username = username
    @password = password
    @from     = from
    @port     = port
  end

  def build_email_msg (subject, hotnews, extra={})
    msg =       "Subject: #{subject}\n\n"
    msg = msg + "Mean: #{extra[:mean]}\n" 
    msg = msg + "Median: #{extra[:median]}\n"
    msg = msg + "Mode: #{extra[:mode]}\n\n"
    msg = msg + "Trending topics !\n\n"

    hotnews.each { |item|
      msg = msg + "#{item['title']} \n"
      msg = msg + "#{item['url']} \n"
      msg = msg + "Points: #{item['points']} \n\n"
    }

    msg
  end

  def send(to, subject, hotnews, extra={})
    msg = build_email_msg(subject, hotnews, extra)
    
    smtp = Net::SMTP.new(@server, @port)
    # Gmail authentication
    smtp.enable_starttls
    smtp.start('localhost', @username, @password, :login) do
      smtp.send_message(msg, @from, to)
    end
  end
end
