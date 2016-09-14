from nose.tools import assert_equal
from mock import patch
import wsgi, mock


@patch('api.hello_world.get', return_value='Hello World')
def test_application_run(mock_hello_world):
    expected = ['Hello World']
    start_response_mock = mock.MagicMock()
    actual = wsgi.application(None, start_response_mock)
    assert_equal(actual, expected)

