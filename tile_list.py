#!/bin/python

h = []
v = []
tile = []

for i in range(7,15):
	h.append(i)

for i in range(4,10):
	v.append(i)

for i in range(0,len(h)-1):
    for j in range(0,len(v)-1):
		if h[i] < 10 and v[i] >= 10:
			tile.append("h0" +  str(h[i]) + "v" + str(v[j]))
		elif v[j] < 10 and h[i] >= 10:
			tile.append("h" +  str(h[i]) + "v0" + str(v[j]))
		elif h[i] < 10 and v[j] < 10:
			tile.append("h0" +  str(h[i]) + "v0" + str(v[j]))
		else:
			tile.append("h" + str(h[i]) + "v" + str(v[j]))


fw = open('tile_list.txt', 'w')
fw.write(str(tile))
fw.close()

