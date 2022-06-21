cd $HOME/massa/massa-client
massa_wallet_address=$(./massa-client wallet_info | grep Address | awk '{ print $2 }')
balance_rolls=$(./massa-client wallet_info | grep "Final rolls" | awk '{ print $3 }')
balance_token=$(./massa-client wallet_info | grep "Final balance" | awk '{ print $3 }')
int_balance_rolls=${balance_rolls%%.*}
int_balance_token=${balance_token%%.*}
echo $balance_rolls
echo $balance_token
echo $int_balance_rolls
echo $int_balance_token
if [[ $int_balance_rolls -le "0" ]] && [[ $int_balance_token -gt "99" ]]; then
                echo "Less than 0"
                resp=$(./massa-client buy_rolls $massa_wallet_address 1 0)
                echo $resp
fi
