FNAME = str-len
SRC = ${FNAME}.asm
build : 
	a68k ${SRC} -o${FNAME}.hex -s -n -rmal

run : build
	d68k ${FNAME}.hex

clear :
	rm -f ${FNAME}.hex
