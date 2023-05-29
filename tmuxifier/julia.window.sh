# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
#window_root "~/Projects/julia"

# Create new window. If no argument is given, window name will be based on
# layout file name.

window_root "$PWD"
new_window "julia"

split_h 50
run_cmd "v ." 1
run_cmd "julia" 2

select_pane 1
