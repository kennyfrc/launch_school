require 'minitest/autorun'

require_relative 'banner'

class BannerTest < Minitest::Test
  def test_to_s
    banner = Banner.new('To boldly go where no one has gone before.')
    expected = <<-BANNER
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
BANNER
    assert_equal(expected, banner.to_s)
  end

  def test_to_s_other
    banner = Banner.new('')
    expected = <<-BANNER
+--+
|  |
|  |
|  |
+--+
BANNER
    assert_equal(expected, banner.to_s)
  end
end