#!/usr/bin/env python3.4

import os


def get_console_size( command ):
	rows, columns = os.popen("stty size", "r").read().split()
	if command == "rows" :
		return rows
	elif command == "cols" :	
		return columns
	else:	
		return "0"	

def get_rows():
	rows = get_console_size("rows")
	return rows

def get_cols():
	cols = get_console_size("cols")
	return cols

print(get_rows())

print(get_cols())
