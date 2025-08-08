from flask import Flask, render_template_string

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Hello from the test app!"

@app.route("/manage_payments")
def manage_payments():
    return "This is the payments page."

@app.route("/test_url")
def test_url():
    # This will test if the url_for for 'manage_payments' can be built.
    template = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>URL Test</title>
    </head>
    <body>
        <h1>Testing url_for</h1>
        <p>Attempting to build URL for 'manage_payments'...</p>
        {%- set url = url_for('manage_payments') -%}
        <p>Success! URL is: {{ url }}</p>
    </body>
    </html>
    """
    return render_template_string(template)

if __name__ == "__main__":
    # Running on a different port to avoid conflict
    app.run(debug=True, port=5001)