require "simplecov"

SimpleCov.start do
  add_filter %r{^/test/}
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "toy_robot"

require "minitest/autorun"

TEST_DIRECTORY = File.expand_path("../../test", __FILE__).freeze
