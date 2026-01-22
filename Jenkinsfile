node ("Worker_Linux") {
    stage ('Git fetch') {
        dir ('playbook') {
              git poll: true, branch: "main", credentialsId: 'admin', url: "git@github.com:deekshithabangera/Hello_World_Project.git"
        } //end of dir
    } //end of stage

    // stage ('Create S3 bucket') {
    //  println "Creating S3 bucket"
    // dir('terraform_files/s3_bucket') {
    //  sh 'terraform init'
    // } //End of dir
    // } // End of build stage
} //end of node