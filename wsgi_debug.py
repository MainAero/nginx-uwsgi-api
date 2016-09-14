from wsgiref.simple_server import make_server

server = make_server('127.0.0.1', 4555, run)
server.serve_forever()
