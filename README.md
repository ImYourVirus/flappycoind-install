This script will automate installing flappycoind on debian systems.  
This script will update apt, install the require dependencies and 
finally flappycoind.  
It will also get a base config and create a  
non priviledged user "flappy" to run the daemon under.  

Tested working on Debian 7.1 Wheezy 32 bit  

Thanks to the folks liquidweb.com for the idea to create a more  
automagical version.  

Source: http://www.liquidweb.com/kb/install-dogecoin-wallet-on-centos/  

Minimal version only installs the daemon, it is for if you already  
have all the prerequisites installed.  
