require 'test_helper'

class UriComponentValidatorTest < Test::Unit::TestCase
  def teardown
    Model.reset_callbacks(:validate)
  end

  def test_valid
    Model.validates :field, uri_component: { component: :ABS_PATH }
    model = Model.new
    model.field = '/some/path'

    assert model.valid?
  end

  def test_invalid
    Model.validates :field, uri_component: { component: :ABS_PATH }
    invalid_paths = ['some/path', '/with/space path']

    invalid_paths.each do |path|
      model = Model.new
      model.field = path
      refute model.valid?
    end
  end

  def test_check_arguments
    assert_raise(ArgumentError) do
      Model.validates :field, uri_component: { component: :WRONG }
    end
  end
end
