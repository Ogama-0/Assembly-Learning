FNAME = LowerCount
SRC = ${FNAME}.asm
build : 
	a68k ${SRC} -o${FNAME}.hex -s -n -rmal

run : build
	d68k ${FNAME}.hex

clean :
	@rm -vf *.hex
