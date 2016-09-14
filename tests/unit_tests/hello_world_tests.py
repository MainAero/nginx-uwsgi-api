from api import hello_world
from nose.tools import assert_equal


def test_hello_world():
    expected = 'Hello World'
    actual = hello_world.get()
    assert_equal(actual, expected)

