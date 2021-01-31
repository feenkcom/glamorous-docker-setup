Author fullName: 'GlamorousToolkit'.

IceCredentialsProvider useCustomSsh: true.
IceCredentialsProvider sshCredentials
	publicKey: '/run/secrets/myid_rsa.pub';
	privateKey: '/run/secrets/myid_rsa'.


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
