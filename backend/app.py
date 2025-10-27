from flask import Flask, request
import sqlite3

app = Flask(__name__)

@app.before_first_request
def setup_db():
    conn = sqlite3.connect("data.db")
    conn.execute("CREATE TABLE IF NOT EXISTS users (name TEXT)")
    conn.close()

@app.route("/submit", methods=["POST"])
def submit():
    name = request.form["name"]
    conn = sqlite3.connect("data.db")
    conn.execute("INSERT INTO users (name) VALUES (?)", (name,))
    conn.commit()
    conn.close()
    return "Submitted!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
