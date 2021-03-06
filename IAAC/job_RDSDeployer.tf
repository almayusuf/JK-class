
resource "jenkins_job" "RDSDeployer" {
	name 				  			   = "RDSDeployer"
	parameters  					   = {
		KeepDependencies 			   = true,
		GitLabConnection			   = "https://github.com/farrukh90/jenkins-class.git",
		TriggerOnPush				   = true,
		TriggerOnMergeRequest		   = true,
		TriggerOpenMergeRequestOnPush  = "never",
		TriggerOnNoteRequest           = true,
		NoteRegex                      = "Jenkins please retry a build",
		CISkip                         = true,
		SkipWorkInProgressMergeRequest = true,
		SetBuildDescription            = true,
		BranchFilterType               = "All",
		SecretToken                    = "{AQAAABAAAAAQwt1GRY9q3ZVQO3gt3epgTsk5dMX+jSacfO7NOzm5Eyk=}",
		UserRemoteConfig			   = "https://github.com/farrukh90/jenkins-class.git",
		BranchSpec                     = "*/main",
		GenerateSubmoduleConfiguration = false,
	}
	template						   = <<EOF
<flow-definition plugin="workflow-job@2.10">
  <actions/>
  <description>{{ .Description }}</description>
  {{- with .Parameters }}
  <keepDependencies>{{ .KeepDependencies }}</keepDependencies>
  <properties>
    <com.dabsquared.gitlabjenkins.connection.GitLabConnectionProperty plugin="gitlab-plugin@1.4.5">
      <gitLabConnection>{{ .GitLabConnection }}</gitLabConnection>
    </com.dabsquared.gitlabjenkins.connection.GitLabConnectionProperty>
    <org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
      <triggers>
        <com.dabsquared.gitlabjenkins.GitLabPushTrigger plugin="gitlab-plugin@1.4.5">
          <spec></spec>
          <triggerOnPush>{{ .TriggerOnPush }}</triggerOnPush>
          <triggerOnMergeRequest>{{ .TriggerOnMergeRequest }}</triggerOnMergeRequest>
          <triggerOpenMergeRequestOnPush>{{ .TriggerOpenMergeRequestOnPush }}</triggerOpenMergeRequestOnPush>
          <triggerOnNoteRequest>{{ .TriggerOnNoteRequest }}</triggerOnNoteRequest>
          <noteRegex>{{ .NoteRegex }}</noteRegex>
          <ciSkip>{{ .CISkip }}</ciSkip>
          <skipWorkInProgressMergeRequest>{{ .SkipWorkInProgressMergeRequest }}</skipWorkInProgressMergeRequest>
          <setBuildDescription>{{ .SetBuildDescription }}</setBuildDescription>
          <branchFilterType>{{ .BranchFilterType }}</branchFilterType>
          <includeBranchesSpec></includeBranchesSpec>
          <excludeBranchesSpec></excludeBranchesSpec>
          <targetBranchRegex></targetBranchRegex>
          <secretToken>{{ .SecretToken }}</secretToken>
        </com.dabsquared.gitlabjenkins.GitLabPushTrigger>
      </triggers>
    </org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.30">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@3.3.0">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>{{ .UserRemoteConfig }}</url>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>{{ .BranchSpec }}</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>{{ .GenerateSubmoduleConfiguration }}</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="list"/>
      <extensions/>
    </scm>
    <scriptPath>Jenkinsfile_RDSDeployer.groovy</scriptPath>
    <lightweight>true</lightweight>
  </definition>
  <triggers/>
  {{- end }}
</flow-definition>	
EOF
}