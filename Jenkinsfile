node ("Worker_Linux") {
    stage ('Git fetch') {
        dir ('playbook') {
             git "git@github.com:deekshithabangera/Hello_World_Project.git"
        } //end of dir
    } //end of stage

    stage ('build') {
     println "entered the build stage"
    } // End of build stage
} //end of node