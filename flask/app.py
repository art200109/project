from flask import Flask
from flask import request
import subprocess
import sys

app = Flask(__name__)

def dockers():
    COMMAND="docker ps --format '{{.Names}} - {{.Image}}'"

    ssh = subprocess.Popen(["ssh", "-o", "StrictHostKeyChecking no", "docker_engine", COMMAND],
                       shell=False,
                       stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE)
    result = ssh.stdout.readlines()
    if result == []:
        error = ssh.stderr.readlines()
        output= "ERROR: %s" % error
    else:
        result = [line.decode('utf-8') for line in result]
        output= '</br>'.join([str(line) for line in result]) 
    return output

@app.route('/')
def hello_world():
    return dockers()


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
