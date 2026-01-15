from typing import Literal, Optional, Tuple
import psutil
import time
import subprocess
import math

UrgencyLevel = Literal["low", "normal", "critical"]

def get_percentage() -> Tuple[int, bool]:
    data = psutil.sensors_battery()
    return math.floor(data.percent), data.power_plugged


def send_notification(
        title,
        text = None,
        icon_path: Optional[str] = None,
        urgency: UrgencyLevel ="normal",
        ) -> None:
    cmd = ["notify-send"]
    cmd += [title]
    cmd += [text] if text else ""
    if icon_path:
        cmd += ["-i", icon_path]
    cmd += ["-u", urgency]
    subprocess.run(cmd)


if __name__ == "__main__":
    warnings = [20, 15, 10]
    levels: list[UrgencyLevel] = ["normal", "normal", "critical"]
    n_warnings = len(warnings)
    is_sent = [False]*n_warnings
    battery_icon = "~/icons/battery-icon.png"
    while True:
        per, plugged = get_percentage()

        for i in range(n_warnings):
            # Send warning if not plugged in, notification not sent yet and percentage goes below warning level
            if per <= warnings[i] and not is_sent[i] and not plugged:
                send_notification(
                                f"Battery {warnings[i]}%",
                                urgency=levels[i],
                                icon_path=battery_icon
                                )
                is_sent[i] = True

            # Reset the warning if plugged in and warning threshhold exceeded
            if per > warnings[i] and plugged:
                is_sent[i] = False

        # Sleep for a bit to not waste excessive amount of cpu cycles
        time.sleep(1)
