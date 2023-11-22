This repository demonstrates a segfault issue which happens when CS2 server becomes full **with SourceTV enabled**.

The version is  `1.39.7.3/13973 9842 secure  public`

## How to replicate the issue
You need to install Docker in Windows or Linux. After that, follow the steps below.

1. Clone this repository `git clone https://github.com/agkr234/cs2_sourcetv_slots_expansion_crash.git`
2. Edit *.credentials* to log into steam in Step 3 (logging into steam is required to download CS2 files)
3. Build the image by executing *build.sh* or *build.bat*
4. Run the container by executing *start.sh* or *start.bat*
5. Wait until the server adds 10 bots + 1 SourceTV and segfault happens

## My thoughts
It seems CS2 server will increase maxplayer slots by +1 when SourceTV is enabled. This means that changing maxplayer slots **dynamically at runtime** is causing the issue.
> [!NOTE]
> You can check this maxplayer slots increase by changing `bot_quota` to 9 in Dockerfile -> rebuilding the image -> running the container -> querying the server with steam client. You will see maxplayer is not 10, but 11 even thought `-maxplayers` is set to 10. (Yes it is because SourceTV expands maxplayer slots)

As a solution, I think it would be better if the codes will be changed like:
- Prohibit the binary from **dynamically** changing the actual maxplayer slots **at runtime**
- Only `-maxplayers` in command line can modify maxplayer slots at startup

In this way, I think the binary won't never cause such an issue in the future and also it would make the codes more safer.

