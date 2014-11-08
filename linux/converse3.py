#!/usr/bin/env python3

#open('examples/chinese.txt', encoding='utf-8')

newline = 0

with open("book.txt", encoding='windows-1250') as f:
    content = f.readlines()

for line in content:
	global newline
	#print("++++++")
	#print(line)
	if len(line) > 20 :
		#print(" 1 if ")
		#print("-1", ord(line[-1]) )
		#print("-2", ord(line[-2]) )
		#print("-3", ord(line[-3]) )
		#if ( ord(line[-1]) == 32 or ord(line[-2]) == 32 or ord(line[-3]) == 32 ):
		#	print("SPACE")
		if ord(line[-1]) == 10:
			#print(" 2 if")
			if ord(line[-2]) == 46 or ord(line[-2]) == 33 or ord(line[-2]) == 63 or ord(line[-2]) == 58:
				#print(" 3 if ")
				print(line)
				with open("outbook.txt", "a", encoding="utf-8") as myfile:
					myfile.write(line)
			elif ord(line[-2]) == 32 and ( ord(line[-3]) == 46 or ord(line[-3]) == 33 or ord(line[-3]) == 63 or ord(line[-3]) == 58):
				print(line)
				with open("outbook.txt", "a", encoding="utf-8") as myfile:
					myfile.write(line)
			else:
				#print(" 3 else ")
				print(line[0:-1], end="")
				with open("outbook.txt", "a", encoding="utf-8") as myfile:
					myfile.write( line[0:-1] )
		else:
			#print(" 2 else")
			print(line[0:-1], end="")
			with open("outbook.txt", "a", encoding="utf-8") as myfile:
				myfile.write( line[0:-1] )
	else:
		#print(" 1 else")
		print(line, end="")
		with open("outbook.txt", "a", encoding="utf-8") as myfile:
			myfile.write( line )
