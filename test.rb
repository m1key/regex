require 'minitest/autorun'
require 'gallery_generator'

require_relative 'regex'

class FullTest < Minitest::Test

  def test_single_param
    extractor = Extractor.new("Test <param> test.")
    assert_equal ["param"], extractor.params, "Extracted param not as expected"
  end

  def test_single_param_with_space
    extractor = Extractor.new("Test <param 1> test.")
    assert_equal ["param 1"], extractor.params, "Extracted param not as expected"
  end

  def test_multiple_params
    extractor = Extractor.new("Test <param 1> test <Param>.")
    assert_equal ["param 1", "Param"], extractor.params, "Extracted params not as expected"
  end
  
  def test_single_thing
    extractor = Extractor.new("Test \"thing\" test.")
    assert_equal ["thing"], extractor.things, "Extracted thing not as expected"
  end

  def test_single_thing_with_space
    extractor = Extractor.new("Test \"thing 1\" test.")
    assert_equal ["thing 1"], extractor.things, "Extracted thing not as expected"
  end

  def test_multiple_things
    extractor = Extractor.new("Test \"thing 1\" test \"Thing\".")
    assert_equal ["thing 1", "Thing"], extractor.things, "Extracted things not as expected"
  end

  def test_multiple_things_and_params
    extractor = Extractor.new("Test <param 1> and \"thing 1\" test <Param> blah \"Thing\".")
    assert_equal ["thing 1", "Thing"], extractor.things, "Extracted things not as expected"
    assert_equal ["param 1", "Param"], extractor.params, "Extracted params not as expected"
  end

  def test_single_number
    extractor = Extractor.new("Test 516 test.")
    assert_equal ["516"], extractor.numbers, "Extracted number not as expected"
  end

  def test_multiple_numbers
    extractor = Extractor.new("Test 516 test 12.")
    assert_equal ["516", "12"], extractor.numbers, "Extracted numbers not as expected"
  end

  def test_multiple_things_and_params
    extractor = Extractor.new("Test <param 1 a> 69 and \"thing 2\" test <Param> 314 blah \"Thing\".")
    assert_equal ["thing 2", "Thing"], extractor.things, "Extracted things not as expected"
    assert_equal ["param 1 a", "Param"], extractor.params, "Extracted params not as expected"
    assert_equal ["69", "314"], extractor.numbers, "Extracted numbers not as expected"
  end

  def test_multiple_things_and_params_2
    extractor = Extractor.new("<param 1> \"69\" 7 and \"thing 2\" test <5 Param> 314 blah \"Thing\".")
    assert_equal ["69", "thing 2", "Thing"], extractor.things, "Extracted things not as expected"
    assert_equal ["param 1", "5 Param"], extractor.params, "Extracted params not as expected"
    assert_equal ["7", "314"], extractor.numbers, "Extracted numbers not as expected"
  end


end

