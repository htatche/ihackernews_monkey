require 'test/unit'
require 'ihackernews'

class IhackednewsTest < Test::Unit::TestCase
  def setup
    @hacknews = Ihackernews.new
    @hacknews.fetch
  end

  def test_fetch_not_empty
    assert_operator @hacknews.items.length, '>', 0
  end

  def test_hotnews_not_empty
    assert_operator @hacknews.hotnews.length, '>', 0
  end

  def test_median_is_float
    assert (@hacknews.median.is_a? Float)
  end

  def test_mean_is_float_or_integer
    assert (
      (@hacknews.mean.is_a? Float) || ( @hacknews.mean.is_a? Integer)
    )
  end

  def test_mode_is_integer
    assert (@hacknews.mode.is_a? Integer)
  end
end
