#BY SUBMITTING THIS FILE TO CARMEN,I CERTIFY THAT I HAVE STRICTLY
#ADHERED TO THE TENURES OF THE OHIO STATE UNIVERSITY'S ACADEMIC
#INTEGRITY POLICTY WITH REGARDS TO THIS ASSIGNMENT.
#Name: Yihone Chu
gcc_Sopt = -lc -m64 -c -g
all: lab7.zip readRec

lab7.zip:
	zip lab7.zip Makefile readRec.s readLines.s compute.s printLines.s LAB7README

readRec: readRec.o readLines.o compute.o printLines.o
	gcc readRec.o readLines.o compute.o printLines.o -o readRec

readRec.o: readRec.s
	gcc $(gcc_Sopt) readRec.s

readLines.o: readLines.s
	gcc $(gcc_Sopt) readLines.s

compute.o: compute.s
	gcc $(gcc_Sopt) compute.s

printLines.o: printLines.s
	gcc $(gcc_Sopt) printLines.s

clean:
	rm -rf *.o readRec lab7.zip
