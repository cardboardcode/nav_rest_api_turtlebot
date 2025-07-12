#!/usr/bin/env python3

import rospy
from std_msgs.msg import String
from kabam_msgs.srv import ParamTrigger, ParamTriggerResponse

class TB3MapServer:
    def __init__(self):
        rospy.init_node('map_server')
        self.available_maps = ['L1', 'L2']
        self.current_map = self.available_maps[0]
        self.change_map_srv = rospy.Service('/change_map', ParamTrigger, self.handle_map_callback)
        self.map_pub = rospy.Publisher('/map_server', String, queue_size=10)
        rospy.Timer(rospy.Duration(1), self.publish_map_callback)

    def handle_map_callback(self, req):

        if len(req.parameter_list) != 1:
            rospy.logwarn(f'Received invalid map request. Ignoring...')
            return ParamTriggerResponse(success=False, message="Invalid map request.")

        rospy.loginfo(f'Received request to change map to [{req.parameter_list[0]}]...')

        is_part_of_available_maps = False
        for map in self.available_maps:
            if map == req.parameter_list[0]:
                is_part_of_available_maps = True

        if is_part_of_available_maps:
            if not self.current_map == req.parameter_list[0]:
                rospy.loginfo(f'Current map updated from [{self.current_map}] to [{req.parameter_list[0]}]...')
                self.current_map = req.parameter_list[0]
                return ParamTriggerResponse(success=True, message=f"Map changed to [ {self.current_map} ].")
            else:
                rospy.loginfo(f'Current map is already [{req.parameter_list[0]}]. No change made...')
                return ParamTriggerResponse(success=True, message="Map already target map.")
        else:
            rospy.logwarn(f'Target map [{req.parameter_list[0]}] does not exist. Available maps: [{self.available_maps}]...')
            return ParamTriggerResponse(success=False, message="Robot does not have target map.")

    def publish_map_callback(self, event=None):
        self.map_pub.publish(self.current_map)

if __name__ == '__main__':
    image_saver = TB3MapServer()
    rospy.spin()