require_relative 'helper'

class HTTPProtocolTest < Minitest::Test
  attr_reader :api_key
  def setup
    @previous_api_key = HostedGraphite.api_key
    @api_key = SecureRandom.uuid
    HostedGraphite.api_key = @api_key
    HostedGraphite.protocol = HostedGraphite::HTTP
  end

  def teardown
    HostedGraphite.api_key = @previous_api_key
  end

  def test_http_protocol
    assert_instance_of HostedGraphite::HTTP, HostedGraphite.protocol
  end

  def test_correct_query
    query = HostedGraphite.send_metric('foo', 1.2, 1421792423)
    assert_equal 'foo 1.2 1421792423', query
  end
end
