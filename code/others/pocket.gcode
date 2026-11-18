(Cut a 40 mm x 20 mm rectangular pocket outline, 2 mm deep)
G21                (units: millimetres)
G90                (absolute coordinates)
M03 S8000          (spindle on, clockwise, 8000 rpm)
G00 X0 Y0 Z5       (rapid move above the start point)
G01 Z-2 F100       (feed down into the material at 100 mm/min)
G01 X40 F400       (cut along the edges)
G01 Y20
G01 X0
G01 Y0
G00 Z5             (retract)
M05                (spindle off)
M30                (end of program)
