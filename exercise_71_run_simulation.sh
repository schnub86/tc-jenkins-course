# Echo the NAME parameter
echo "Hello my name is $NAME!"

case $MOVE_ROBOT in 
	true)
		# Start the ROS script that MOVES the robot around in the background
		# Capture the process ID of that script in MOVE_ID
		# Wait for MOVE seconds and then kill the process
		roslaunch publisher_example move.launch &
		MOVE_ID=$!
		sleep ${MOVE}s
		kill $MOVE_ID

		# Start the ROS script that STOPS the robot in the background
		# Capture the process ID of that script in STOP_ID
		# Wait for 5 seconds and then kill the process
		roslaunch publisher_example stop.launch &
		STOP_ID=$!
		sleep 15s
		kill $STOP_ID

		# Call the Gazebo service that resets the simulation
		# ...if enabled
		case $RESET_SIMULATION in
    		true)    
    			rosservice call /gazebo/reset_simulation "{}"
    			echo "Simulation has been reset."
    			;;
  			false)   
    			echo "Not resetting the simulation."
    			;; 
		esac
		;;
	false)
      echo "Skipping sim"
      ;;
esac

# Print the text that indicates that we are done here
echo "Job finished"