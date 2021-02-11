Author fullName: 'GlamorousToolkit'.

githubToken := OSEnvironment current at: 'GITHUB_TOKEN' ifAbsent: [nil].

githubToken ifNil: [
    IceCredentialsProvider useCustomSsh: true.
    IceCredentialsProvider sshCredentials
        publicKey: '/run/secrets/myid_rsa.pub';
        privateKey: '/run/secrets/myid_rsa'.
] ifNotNil: [
    IceCredentialStore current
        storeCredential: (IceTokenCredentials new
            username: 'githubuser@user.noreply.github.com';
            token: githubToken;
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
