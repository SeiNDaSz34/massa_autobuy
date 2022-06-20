#!/bin/bash
#Thank's for https://raw.githubusercontent.com/bobu4/massa/main/bal.sh

rm -f $HOME/massa/massa-client/massa-client
if [ ! -e $HOME/massa/massa-client/massa-client ]; then
  wget https://raw.githubusercontent.com/razumv/helpers/main/massa/massa-client -O $HOME/massa/massa-client/massa-client
  chmod +x $HOME/massa/massa-client/massa-client
fi
#
cd $HOME/massa/massa-client
massa_wallet_address=$(./massa-client wallet_info | grep Address | awk '{ print $2 }')
while true
do
        balance_rolls=$(./massa-client wallet_info | grep "Final rolls" | awk '{ print $3 }')
        balance_token=$(./massa-client wallet_info | grep "Final balance" | awk '{ print $3 }')
        int_balance_rolls=${balance_rolls%%.*}
        int_balance_token=${balance_token%%.*}
        if [[ $int_balance_rolls -le "0" ] && [ $int_balance_token -gt "99" ]]; then
                echo "Less than 0"
                resp=$(./massa-client buy_rolls $massa_wallet_address 1 0)
                echo $resp
        elif [ $int_balance_rolls -ge "1" ]; then
                echo "More than 1"
        fi
        printf "sleep"
        for((sec=0; sec<60; sec++))
        do
                printf "."
                sleep 1
        done
        printf "\n"
done
