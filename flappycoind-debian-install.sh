#    Version .01
#    Written by ImYourVirus feel free to reuse it in other works for free
#    as long as these notices are kept.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#    If you like the work I have put into this script feel free to donate
#    to the work that I have put into this script. Thanks.
#
#    BTC:  1Hq3kzVoLyg5UF8GuCKZacreRzmZPU8s16
#    LTC:  LdkMYTpzcfCYnkjaMsmBEPce4xQ2r1VPbq
#    DOGE: D6bS3eK35SfqcFbnUWUnqtKA87DkFy6Vun
#
#

# Update Server
apt-get -y update

# Step #1: Installing the Dependencies
apt-get -y install gcc make bzip2 build-essential git openssl libboost-all-dev libboost-dev libdb5.1 libdb++-dev

# Step #2: Installing flappycoind
cd /usr/local/src
ldconfig
mkdir /usr/local/src/flappycoin-master
cd /usr/local/src/flappycoin-master
wget -qO- https://api.github.com/repos/flappycoin-project/flappycoin/tarball/master --no-check-certificate | tar xfzv -
cd flappycoin*/src
#make -f makefile.unix USE_UPNP=- BDB_LIB_PATH=/usr/local/lib OPENSSL_LIB_PATH=/usr/local/lib
make -f makefile.unix USE_UPNP=- 


# Step #2.1 The flappycoind binary should now be compiled. Next we.ll strip the debugging symbols out of the 
#  binary and move it to a location that allows for easy execution.

strip flappycoind
cp -a flappycoind /usr/local/bin/


# Step #3: Configuring flappycoind
#   Most scrypt-based cryptocurrencies use a configuration file that is nearly identical to LiteCoin's.
#   It is generally safe to use Litecoin documentation when looking up configuration variables.
#   If you do not have a standard non-root user, then you can create one using the useradd command.
#   In this example we.re going to create a user named flappy.
useradd -m -s/bin/bash flappy

mkdir /home/flappy/.flappycoin
chown flappy:flappy /home/flappy/.flappycoin
cd /home/flappy/.flappycoin
pass=$(tr -dc A-Za-z0-9 </dev/urandom |  head -c 30)
echo "rpcuser=flappycoin
rpcpassword=$pass
daemon=1
listen=1
server=1
#alertnotify=echo %s | mail -s "flappycoin Alert" admin@foo.com
" >> flappycoin.conf
chown flappy:flappy flappycoin.conf

# Assume the identity of the non-privileged user, flappy.
su - flappy

# Now that you.ve assumed the identity of a non-privileged user, you will want to run flappycoind for the first time.
flappycoind

