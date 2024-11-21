#BY SUBMITTING THIS FILE TO CARMEN, I CERTIFY THAT I HAVE STRICTLY ADHERED
#TO THE TENURES OF THE OHIO STATE UNIVERSITY'S ACADEMIC INTEGRITY POLICY
#WITH REGARDS TO THIS ASSIGNMENT.
#Name: Yihone Chu
.file "readRec.s"

.section .rodata

mode:
	.string "r"

.globl main
	.type main, @function 

.text
	#RDI IS ARGC
	#RSI IS ARGV
	
main:
	#Set up stack frame
	pushq %rbp
	movq %rsp, %rbp 
	
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	#Exit the program is argc is less than 2
	cmpl $3, %edi
	js exit
	
	#Deference argv to get the strings
	movq 8(%rsi), %rdi#We do not need argc anymore after checking it.
	#Call atoi	
	pushq %rsi
	call atoi
	popq %rsi
	#Save the number of records into 
	#push and pop before
	movl %eax, %r12d
	
	#Get the filename and store it in rdi as well as r14
	movq 16(%rsi), %rdi		
	#open file
	movq $mode, %rsi		
	call fopen
	#See if opening pointer returns null
	cmpq $0, %rax
	je exit #jump if fopen returns null

	movq %rax, %r14
	
	#Calling malloc with size of structure times the number of structures
	movl $40, %edi
	imull %r12d, %edi
	call malloc
	#pop all of back

	#Check if malloc returns a null pointer and exit if it does
	cmpq $0, %rax
	je exit	
	#R15 IS START OF MALLOC	
	movq %rax, %r15

	#R14 is the filename, R15 is the malloc thing and R12D is the counts


	#NOW CALLING READLINES
	#MOVE THE FILE POINTER AS WELL AS THE MALLOC ADDRESS INTO THE 1st and 2nd parameters respectively.
	movq %r14, %rdi
	movq %r15, %rsi
	movl %r12d, %edx

	call readLines
	
	movq %r14, %rdi
	call fclose

	#NOW CALLING COMPUTE
	movq %r15, %rdi
	movl %r12d, %esi

	call compute	

	#NOW CALLING PRINTLINES
	movq %r15, %rdi
	movl %r12d, %esi
	
	call printLines
	

exit:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	leave
	ret

.size main, .-main
