require 'ihackernews'

hacknews = Ihackernews.new
hacknews.fetch

puts "Mean: #{hacknews.mean}"
puts "Median: #{hacknews.median}"
puts "Mode: #{hacknews.mode}"

puts "Current hot news:"
hacknews.print

mail = Ihackernews::Mail.new(
  'smtp.gmail.com',
  587,
  'you@gmail.com',
  'password',
  'you@gmail.com'
)

extra = {
  :mean   => hacknews.mean,
  :median => hacknews.median,
  :mode   => hacknews.mode,
}

puts 'Sending an email !'
hotnews = hacknews.hotnews
mail.send('receiver@xxx.com', 'Fresh news from ihackernews!', hotnews, extra)
