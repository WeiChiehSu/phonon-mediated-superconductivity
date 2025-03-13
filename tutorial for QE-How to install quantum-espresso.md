We use quantum espresso 6.8 version to calculate material superconditivy.
After installing quantum espresso, we need to install oneapi to auxiliary operating software.

##########################################################################################################

# download oneapi

wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18445/l_BaseKit_p_2022.1.1.119_offline.sh

wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18438/l_HPCKit_p_2022.1.1.97_offline.sh

##########################################################################################################

# compile oneapi

sh ./l_BaseKit_p_2022.1.1.119_offline.sh

sh ./l_HPCKit_p_2022.1.1.97_offline.sh

###########################################################################################################

When we finish installing oneapi, we can start to install quantum espresso

###########################################################################################################

# download quantum espresso 6.8

wget https://github.com/QEF/q-e/releases/download/qe-6.8/qe-6.8-ReleasePack.tgz

###########################################################################################################

# compile quantum espresso 6.8 with oneapi

tar zxvf qe-6.8-ReleasePack.tgz

cd qe-6.8/

source ~/intel/oneapi/setvars.sh

./configure

make all

make epw

###########################################################################################################
