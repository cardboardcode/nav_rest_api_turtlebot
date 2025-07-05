#!/usr/bin/env python3

import rospy
from std_msgs.msg import String
from sensor_msgs.msg import Image

class TB3MapServer:
    def __init__(self):
        rospy.init_node('map_server')
        self.available_maps = ['L1', 'L2']
        self.current_map = self.available_maps[0]
        self.change_map_sub = rospy.Subscriber("/change_map", String, self.change_map_callback)

        self.map_pub = rospy.Publisher('/map_server', String, queue_size=10)
        rospy.Timer(rospy.Duration(1), self.publish_map_callback)

    def change_map_callback(self, msg):
        rospy.loginfo(f'Received request to change map to [{msg.data}]...')

        is_part_of_available_maps = False
        for map in self.available_maps:
            if map == msg.data:
                is_part_of_available_maps = True

        if is_part_of_available_maps:
            if not self.current_map == msg.data:
                rospy.loginfo(f'Current map updated from [{self.current_map}] to [{msg.data}]...')
                self.current_map = msg.data
            else:
                rospy.loginfo(f'Current map is already [{msg.data}]. No change made...')
        else:
            rospy.logwarn(f'Target map [{msg.data}] does not exist. Available maps: [{self.available_maps}]...')

    def publish_map_callback(self, event=None):
        self.map_pub.publish(self.current_map)

if __name__ == '__main__':
    image_saver = TB3MapServer()
    rospy.spin()