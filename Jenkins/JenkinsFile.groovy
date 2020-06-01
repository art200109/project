def pipeline_script = readFileFromWorkspace('.git_pipeline.groovy')
pipelineJob('git') {
  definition
  {
    cps{
     script(pipeline_script)
     sandbox()
  	}
  
}
}
/*  */
def flask_path = '/var/lib/jenkins/workspace/git/flask/.'
job('flask') {
    steps {
      	shell('cp -a '+flask_path+" ./")
      	shell('sudo chmod u+x ./build_script.sh')
        shell('sudo ./build_script.sh')
    }
  	triggers {
  		upstream('git','SUCCESS')
  	}
  	wrappers {
        preBuildCleanup()
    }
}

def nginx_path = '/var/lib/jenkins/workspace/git/nginx/.'
job('nginx') {
    steps {
      	shell('cp -a '+nginx_path+" ./")
      	shell('sudo chmod u+x ./build_script.sh')
        shell('sudo ./build_script.sh')
    }
  	triggers {
  		upstream('flask','SUCCESS')
  	}
  	wrappers {
        preBuildCleanup()
    }
}

def run_path = '/var/lib/jenkins/workspace/git/run_script.sh'
job('run') {
    steps {
      	shell('cp '+run_path+" ./")
      	shell('sudo chmod u+x ./run_script.sh')
        shell('sudo ./run_script.sh')
      	shell('curl 127.0.0.1:80')
    }
  	triggers {
  		upstream('nginx','SUCCESS')
  	}
  	wrappers {
        preBuildCleanup()
    }
}

queue('git')
