from nose.tools import assert_equal
import mock, wsgi


def test_hello_world():
    expected = ['Hello World']
    start_response_mock = mock.MagicMock()
    
    actual = wsgi.application(None, start_response_mock)

    start_response_mock.assert_called_once_with('200 OK', [('Content-Type', 'text/html')])
    assert_equal(actual, expected)

