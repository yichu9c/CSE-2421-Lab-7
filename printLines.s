#BY SUBMITTING THIS FILE TO CARMEN, I CERTIFY THAT I HAVE STRICTLY ADHERED
#TO THE TENURES OF THE OHIO STATE UNIVERSITY'S ACADEMIC INTEGRITY POLICY
#WITH REGARDS TO THIS ASSIGNMENT.
#Name: Yihone Chu

.file "printLines.s"

.section .rodata

sumFormat:
	.string "%d + %d = %ld\n"

subFormat:
	.string "%d - %d = %d\n"

mulFormat:
	.string "%d * %d = %ld\n"

divFormat:
	.string "%d / %d = %d,%d\n\n"


.globl printLines
	.type printLines, @function 

.text
printLines:
	push %rbp
	movq %rsp, %rbp
	
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	#Save hese registers because we will have to call printf
	movq %rdi, %r12
	movq %rsi, %r13
	
	movq $-1, %r14

	loop:
		incq %r14
		cmpl %r13d, %r14d
		jge exit
		
		#V2
		movl (%r12), %ebx
		#V1
		movl 4(%r12), %r15d	

		#PRINTING SUM		
		#Move format
		movq $sumFormat, %rdi

		#Get v2
		movl %ebx, %edx
		#Get v1
		movl %r15d, %esi

		#Get the sum
		movq 16(%r12) , %rcx
	
		movq $0, %rax
		call printf

		#PRINTING SUBTRACTION
		
		#Move format
		movq $subFormat, %rdi
			
		#Get v2
		movl %ebx, %edx
		#Get v1
		movl %r15d, %esi

		#Get the difference part of struct
		movl 8(%r12), %ecx 
		
		movq $0, %rax		
		call printf

		#PRINTING MULTIPLICATION
		movq $mulFormat, %rdi
		
		#Get v2
		movl %ebx, %edx
		#Get v1
		movl %r15d, %esi
		
		#Get the product part of struct
		movq 24(%r12), %rcx
		movq $0, %rax
		call printf

		#PRINTING DIVISION
		movq $divFormat, %rdi
			
		#Get v2
		movl %ebx, %edx
		#Get v1
		movl %r15d, %esi
	
		#Get the quotient and remainder
		movl 32(%r12), %ecx
		movl 36(%r12), %r8d
		
		movq $0, %rax
		call printf	
		
		leaq 40(%r12), %r12
	
		jmp loop	
	
	
	exit:
		popq %r15
		popq %r14
		popq %r13
		popq %r12
		leave
		ret
	
.size printLines, .-printLines
