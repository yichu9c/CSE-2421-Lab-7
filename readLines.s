#BY SUBMITTING THIS FILE TO CARMEN, I CERTIFY THAT I HAVE STRICTLY ADHERED TO THE TENURES OF THE OHIO 
#STATE UNIVERSITY'S ACADEMIC INTEGRITY POLICY WITH REGARDS TO THIS ASSIGNMENT.
#Name: Yihone Chu

.file "readLines.s"

.section .rodata
format:
	.string "%d%d"
.data

.globl readLines
	.type readLines, @function 

.text

readLines:
	#Set up stack frame
	pushq %rbp
	movq %rsp, %rbp	

	pushq %r12	
	pushq %r13
	pushq %r14
	pushq %r15
	#Save the structure pointer and the structure count to other registers that way we can call other functions with paramemeters.
	movq %rdi, %r12
	movq %rsi, %r13
	movq %rdx, %r14
		
	movq $-1, %r15
	loop:
		#compare loop counter
		incl %r15d
		cmpl %r14d, %r15d 
		jge exit
	
		#move file pointer into first parameter
		movq %r12, %rdi
		
		#move format into the second parameter			
		movq $format, %rsi
	
		#moving v2 of struct into 3rd parameter
		movq %r13, %rcx	
		#moving v1 of strcut into 4th parameter
		leaq 4(%r13), %rdx
	
		xorq %rax, %rax
		call fscanf
		
		#TESTING
		movq (%r13), %r9
		movq 4(%r13), %r10
		
		leaq 40(%r13), %r13 
			
		#check to see if fscanf returned end of file
		cmpl $-1, %eax
		je exit
	
		jmp loop
exit:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	
	leave
	ret	

.size readLines, .-readLines
	

