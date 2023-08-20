#!/usr/bin/python3

import json
from sys import argv

f = open("./knock-results/"+argv[1]+".json",)

data = json.load(f)

with open("./knock-results/"+argv[1]+".txt","+a") as f:
	for i in data.keys():
		if (i!='_meta'):
			f.write(i+"\n")
	d = f.read()
	if(len(d)==0):
		f.write(" ")

f.close() 
