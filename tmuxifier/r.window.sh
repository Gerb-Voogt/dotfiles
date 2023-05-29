# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
#window_root "~/Projects/r"

# Create new window. If no argument is given, window name will be based on
# layout file name.
window_root "$PWD"
new_window "r"

split_h 50
run_cmd "v ." 1
run_cmd "R" 2

select_pane 1
