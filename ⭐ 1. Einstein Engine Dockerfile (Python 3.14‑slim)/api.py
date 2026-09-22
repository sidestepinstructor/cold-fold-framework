from flask import Flask, request, jsonify
from Einstein import cycle
app = Flask(__name__)
@app.route('/cycle', methods=['POST'])
def run_cycle():
    return jsonify(cycle(request.json))
app.run(host='0.0.0.0', port=5000)
