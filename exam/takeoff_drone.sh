python -m unittest discover -v

# Start the ROS script that TAKES OFF the drone in the background
# Capture the process ID of that script in TAKEOFF_ID
# Wait for 15 seconds and then kill the process
rostopic pub /drone/takeoff std_msgs/Empty '{}' &
TAKEOFF_ID=$!
sleep 15s
kill $TAKEOFF_ID