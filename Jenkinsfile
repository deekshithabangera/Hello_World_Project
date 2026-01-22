node ("Worker_Linux") {
    stage ('Git fetch') {
        dir ('playbook') {
              git poll: true, branch: "main", credentialsId: 'admin', url: "git@github.com:deekshithabangera/Hello_World_Project.git"
        } //end of dir
    } //end of stage

    stage('Terraform Init') {
        dir('playbook/terraform_files/s3_bucket') {
            sh 'terraform init'
        }
    }
} //end of node