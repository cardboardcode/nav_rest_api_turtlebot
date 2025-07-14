#!/usr/bin/env python3

import rospy
from std_msgs.msg import String
from kabam_msgs.msg import TaskParam
from actionlib_msgs.msg import GoalStatusArray

class StateAggregator:
    def __init__(self):
        rospy.init_node('state_aggregator')
        self.nav_status = None
        self.nav_msg = None
        self.map_name = None
        self.battery = 0.9
        self.navstatus_sub = rospy.Subscriber('/move_base/status', GoalStatusArray, self.navstatus_callback)
        self.map_sub = rospy.Subscriber('/map_server', String, self.map_callback)

        self.state_pub = rospy.Publisher('/state_aggregator', TaskParam, queue_size=10)
        rospy.Timer(rospy.Duration(1), self.publish_state)

    def navstatus_callback(self, msg):
        rospy.loginfo(f'Received msg from [/move_base/status]')

        if len(msg.status_list) != 0:
            self.nav_status = msg.status_list[0].status
            self.nav_msg = msg.status_list[0].text
        else:
            self.nav_msg = "Idling"

    def map_callback(self, msg):
        rospy.loginfo(f'Received msg from [/map_server]')
        self.map_name = msg.data

    def publish_state(self, event=None):
        # Co-opting TaskParam to transfer state messages
        msg = TaskParam()
        msg.parameter_list.append(self.map_name)
        msg.parameter_list.append(str(self.battery))
        msg.parameter_list.append(str(self.nav_status))
        msg.parameter_list.append(self.nav_msg)

        self.state_pub.publish(msg)

if __name__ == '__main__':
    image_saver = StateAggregator()
    rospy.spin()