#BY SUbMITTING THIS FILE TO CARMEN, I CERTIY THAT I HAVE STRICTLY ADHERED
#TO THE TENURES OF THE OHIO STATE UNIVERSITY'S ACADEMIC INTEGRITY POLICY
#WITH REGARDS TO THIS ASSIGNMENT.
#Name: Yihone Chu

.file "compute.s"

.globl compute
	.type compute, @function

.section  .text
compute:
	#Set up stack frame and push callee saved registers
	pushq %rbp
	movq %rsp, %rbp

	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15	

	#Move the counts into %r12
	movq %rdi, %r15
	movq %rsi, %r12
		
	movq $-1, %r13
		
	loop:
		#Compare loop vari
		incl %r13d
		cmpl %r12d, %r13d
		jge exit
			
		#SUBCTRACTION
		#Get V2
		movl (%r15),%r8d
	
		#Get V1
		movl 4(%r15), %r9d

		#Compute the subtraction
		subl %r8d, %r9d
		
		#Compute the address of the subtraction value in the struct
		movl %r9d, 8(%r15) 		

		#SUMMATION
		#Addition
		#Get V2
		movslq (%r15), %r8
		#Get V1
		movslq 4(%r15), %r9

		#Compute the summation
		addq %r8, %r9	

		#Compute the address of the summation value in the struct
		movq %r9, 16(%r15)
	
		#MULTIPLICATION
		#Get V2
		movslq (%r15), %r8
		#Get V1
		movslq 4(%r15), %r9		

		#Perform multiplication
		imulq %r8, %r9
		
		#calculate the address of the product value in the structure
		movq %r9, 24(%r15)
		
		#DIVISION
		#Get V2 
		movslq 4(%r15), %rax
		#Get V1
		movslq (%r15), %rsi
		
		
		#Perform division operation as shown in the slides
		cqto
		idivq %rsi		
	
		#Put the quotient and remainder into struct
		movl %eax, 32(%r15)
		movl %edx, 36(%r15)
		
		leaq 40(%r15), %r15


		jmp loop
		
exit:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	leave
	ret
.size compute, .-compute	
