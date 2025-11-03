from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET')
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        return super().end_headers()

    def do_GET(self):
        return SimpleHTTPRequestHandler.do_GET(self)

# Change to the directory containing your files
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# Start the server
PORT = 8000
print(f"Server starting at http://localhost:{PORT}")
print("Press Ctrl+C to stop")
HTTPServer(("", PORT), CORSRequestHandler).serve_forever()
