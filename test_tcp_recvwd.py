import http.server as server
import socketserver

PORT = 8000

Handler = server.SimpleHTTPRequestHandler
httpd = socketserver.TCPServer(("", PORT), Handler)
httpd.socket.
print("serving at port")
httpd.serve_forever()