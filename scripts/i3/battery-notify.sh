battery_min_reminder_1=20
battery_min_reminder_2=15
battery_min_urgent=10
send_notification=true
send_notification_2=true
send_critical_notification=true

resetNotifications() {
    battery_percentage=$(acpi -b | grep -P -o "[0-9]+(?=%)")
    if [[ $battery_percentage -gt 20 ]]
    then
        echo "Resetting notification!"
        send_notification=true
        send_critical_notification=true
    fi
}

checkBatteryInfo() {
    battery_percentage=$(acpi -b | grep -P -o "[0-9]+(?=%)")

    if [[ $battery_percentage -le battery_min_reminder_1 ]] && [ $send_notification == true ]
    then
        echo "Discharging, battery low"
        dunstify "Battery Warning" "Battery life has reached 20%!" -u normal
        send_notification=false
    fi

    if [[ $battery_percentage -le battery_min_reminder_2 ]] && [ $send_notification_2 == true ]
    then
        echo "Discharging, battery low"
        dunstify "Battery Warning" "Battery life has reached 15%!" -u normal
        send_notification_2=false
    fi

    if [[ $battery_percentage -le $battery_min_urgent ]] && [ $send_critical_notification == true ]
    then
        echo "Discharging, battery critical"
        dunstify "Critical Battery Warning" "Battery life has reached 10%!" -u critical
        send_critical_notification=false
    fi
}

while true
do
    checkBatteryInfo
    resetNotifications
    sleep 1s
done
