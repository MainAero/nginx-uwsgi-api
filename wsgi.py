from api import hello_world


def application(environ, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    return [hello_world.get()] 

