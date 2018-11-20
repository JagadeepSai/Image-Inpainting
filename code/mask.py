import numpy as np
import cv2
import argparse

ap = argparse.ArgumentParser()
ap.add_argument("-i", "--input", required=True,
	help="input image")
ap.add_argument("-o", "--output", required=True,
	help="output image")
args = vars(ap.parse_args())
input = args["input"]
output = args["output"]
img = cv2.imread(input)
height, width, channels = img.shape
drawing = False
mode = True
ix,iy = -1,-1
radius = 5

def draw_circle(event,x,y,flags,param):
	global ix,iy,drawing,mode
	if event == cv2.EVENT_LBUTTONDOWN:
		drawing = True
		ix,iy = x,y

	elif event == cv2.EVENT_MOUSEMOVE:
		if drawing == True:
			if mode == True:
				cv2.rectangle(mask,(ix,iy),(x,y),(0,0,0),-1)
				cv2.rectangle(img,(ix,iy),(x,y),(0,0,0),-1)
			else:
				cv2.circle(mask,(x,y),radius,(0,0,0),-1)
				cv2.circle(img,(x,y),radius,(0,0,0),-1)
	elif event == cv2.EVENT_LBUTTONUP:
		drawing = False
		if mode == True:
			cv2.rectangle(mask,(ix,iy),(x,y),(0,0,0),-1)
			cv2.rectangle(img,(ix,iy),(x,y),(0,0,0),-1)
		else:
			cv2.circle(mask,(x,y),radius,(0,0,0),-1)
			cv2.circle(img,(x,y),radius,(0,0,0),-1)

mask = np.zeros((height,width,1), np.uint8)
mask.fill(255)
cv2.namedWindow('image')
cv2.setMouseCallback('image', draw_circle)

while(1):
	cv2.imshow('image',img)
	k = cv2.waitKey(1) & 0xFF
	if k == ord('m'):
		mode = not mode
	elif k == ord('+'):
		radius = radius + 1
	elif k==ord('-'):
		radius = max(1, radius-1)
	elif k==ord('s'):
		cv2.imwrite(output,mask)
		break
	elif k == 27:
		break

cv2.destroyAllWindows()