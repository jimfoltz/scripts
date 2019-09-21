# conv.py
FREECAD = 'C:\\Program Files (x86)\\FreeCAD 0.16\\bin'
import sys
sys.path.append(FREECAD)
import FreeCAD
import Part
file = sys.argv[1]
print str(sys.argv)
#part = Part.read("C:/Users/Jim/Downloads/545424.STEP")
part = Part.read(file)
part.exportStl(file + '.stl')

