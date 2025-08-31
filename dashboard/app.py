from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__, static_folder='.', static_url_path='')

JENKINS_URL = "http://localhost:8080"
JENKINS_JOB = "minecraft-on-demand"
JENKINS_USER = "your-admin-user"
JENKINS_TOKEN = "your-jenkins-api-token"

@app.route('/launch', methods=['POST'])
def launch_server():
    data = request.get_json()
    
    params = ""
    for key, value in data.items():
        params += f"-d {key}={value} "

    command = (
        f"curl -X POST {JENKINS_URL}/job/{JENKINS_JOB}/buildWithParameters "
        f"--user {JENKINS_USER}:{JENKINS_TOKEN} "
        f"{params}"
    )

    try:
        subprocess.run(command, shell=True, check=True)
        return jsonify({"message": f"Build triggered for a {data.get('INSTANCE_TYPE')} {data.get('SERVER_TYPE')} server."})
    except subprocess.CalledProcessError as e:
        return jsonify({"error": "Failed to trigger Jenkins job."}), 500

@app.route('/')
def index():
    return app.send_static_file('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
