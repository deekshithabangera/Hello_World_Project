node ("build") {
    stage ('Git fetch') {
        dir ('playbook') {
             git poll: true, branch: "main", credentialsId: 'jenkin_cred', url: "git@github.com:deekshithabangera/Hello_World_Project.git"
        } //end of dir
    } //end of stage

    stage ('build') {
     println "entered the build stage"
    } // End of build stage
} //end of node