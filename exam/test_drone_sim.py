import unittest
import subprocess

class TestSimulation(unittest.TestCase):
    def run_command(self, cmd):
        # Create the shell process
        process = subprocess.Popen(cmd,
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE)
        
        # Get the return code and ensure it exits properly
        return_code = process.wait()
        self.assertEqual(return_code, 0)
        
        # Get the output
        out, err = process.communicate()
        self.assertEqual('', err.decode("utf-8"))

        return out.decode("utf-8"), err.decode("utf-8")

    def test_takeoff_topic(self):
        # run a command
        out, err = self.run_command('rostopic list')       
        self.assertIn('/drone/takeoff', str(out))
    
    def test_gt_pose_topic(self):
        out, err = self.run_command('rostopic list')
        self.assertIn('/drone/gt_pose', out)

    def test_land(self):
        out, err = self.run_command('rostopic list')
        self.assertIn('/drone/land', out)
