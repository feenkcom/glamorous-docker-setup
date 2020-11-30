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
        baseline: 'GlamorousApp';
        onConflictUseIncoming;
        repository: 'github://feenkcom/glamorousapp/src';
        load.
] ensure: [ EpMonitor current enable ].


Smalltalk snapshot: true andQuit: true.
