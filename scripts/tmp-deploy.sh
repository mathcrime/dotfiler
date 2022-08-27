!#/bin/sh

cp -vi *.sh $HOME/bin

cp $HOME/.bashrc $HOME/.bashrc-OLD
chmod 444 $HOME/.bashrc-OLD

cp $HOME/.bash_logout $HOME/.bash_logout-OLD
chmod 444 $HOME/.bash_logout-OLD

cp $HOME/.bash_profile $HOME/.bash_profile-OLD
chmod 444 $HOME/.bash_profile-OLD

cp $HOME/.login_conf $HOME/.login_conf-OLD
chmod 444 $HOME/.login_conf-OLD

cp $HOME/.inputrc $HOME/.inputrc-OLD
chmod 444 $HOME/.inputrc-OLD

mv $HOME/.bashrc.d $HOME/.bashrc.d-OLD
chmod 444 $HOME/.bashrc.d-OLD

cp -vi .bashrc $HOME/.bashrc
cp -vi .bash_profile $HOME/.bash_profile
cp -vi .bash_logout $HOME/.bash_logout
cp -rv .bashrc.d/ $HOME/
cp -vi .inputrc $HOME
cp -vi .login_conf $HOME


