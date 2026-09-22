from flask import Flask, request, jsonify
from Einstein import cycle

app = Flask(__name__)

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/cycle", methods=["POST"])
def run_cycle():
    return jsonify(cycle(request.json))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
