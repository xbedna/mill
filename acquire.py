from harvesters.core import Harvester

import numpy as np
import cv2

h = Harvester()

h.add_file('/opt/mvIMPACT_Acquire/lib/x86_64/mvGenTLProducer.cti')
#h.add_file('/opt/Vimba/VimbaGigETL/CTI/x86_64bit/VimbaGigETL.cti')

print(h.files)
h.update()
p = h.device_info_list
[print(p[i]) for i in range(len(p))]
ia = h.create({'serial_number': 'U320301'})
try:
    ia.start()

    with ia.fetch() as buffer:
        # Work with the Buffer object. It consists of everything you need.
        #print(type(buffer))\
        print(buffer)
        component = buffer.payload.components[0]
        _2d = component.data.reshape(component.height, component.width)
        print('2D: {0}'.format(_2d))
        print(buffer)
        
        cv2.imwrite("image.png",_2d)
        # The buffer will automatically be queued.
finally:
    ia.stop()
    ia.destroy()
    h.reset()
