require 'minitest/autorun'
require 'unihan2'

class Unihan2Test < Minitest::Test
  def setup
    @u2 = Unihan2.new
  end

  def test_strokes
    assert_equal 4, @u2.strokes("中")
  end

  def test_ver
    assert_equal 1.1, @u2.ver("中")
    assert_equal 1.1, @u2.ver('※')
    assert_equal 13.0, @u2.ver('2A6D7')
    assert_equal 13.0, @u2.ver(0x2A6D7)
  end
end