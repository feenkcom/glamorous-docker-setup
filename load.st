Author fullName: 'GlamorousToolkit'.

GitHubToken := OSEnvironment at: 'GITHUB_TOKEN' ifAbsent: [nil].

GitHubToken ifNil: [
    IceCredentialsProvider useCustomSsh: true.
    IceCredentialsProvider sshCredentials
        publicKey: '/run/secrets/myid_rsa.pub';
        privateKey: '/run/secrets/myid_rsa'.
] else: [
    IceCredentialStore current
        storeCredential: (IceTokenCredentials new
            username: 'markfirmware@user.noreply.github.com';
            token: (OSEnvironment at: 'GITHUB_TOKEN' ifAbsent: [Error signal: 'no GITHUB_TOKEN']);
            yourself) 
        forHostname: 'github.com'.
].

EpMonitor current disable.
[
    "Replace the code below with your own repository."
    Metacello new
        onWarningLog;
        baseline: 'GlamorousDockerSetup';
        onConflictUseIncoming;
        repository: 'github://feenkcom/glamorous-docker-setup:main/src';
        load.
] ensure: [ EpMonitor current enable ].


BrGlamorousFonts class compile: 'initializeFonts

.'.


Smalltalk snapshot: true andQuit: true.
