#Roberto Merino
#This progrma allows the user to enter two numbers and a tolerance point and find its root 
#based on the equation of x^3-x-1
#f4:		numA
#f5:		numB
#f6:		numT

		.data
promptA:	.asciiz "\nPlease enter point A: "
promptB:	.asciiz	"\nPlease enter point B: "
promptT:	.asciiz "\nPlease enter the tolerance: "
outputTable:	.asciiz "\na\t\t\tb\t\t\tmidpt\t\t\tf(a)\t\t\tf(b)\t\t\tf(midpt)"
spaceTabs:	.asciiz"\t\t\t"	
newLine:	.asciiz"\n"	
		.globl main
		.text
	
main:	
	# prompts user to enter point A
	li	$v0, 4				#syscall code to print string
	la	$a0, promptA			#loads addr of promptA in $a0
	syscall					#executes prompt	
	li	$v0,6				#reads user input for point A
	syscall					#reads input for Point A into $f0
	mov.s 	$f4,$f0	                        #stores the user input -f4-
	
	# prompts user to enter point B
	li	$v0, 4				#syscall code to print string
	la	$a0, promptB			#loads addr of promptB in $a0
	syscall					#executes prompt	
	li	$v0,6				#reads user input for point B
	syscall					#reads input for Point B into $f0
	mov.s   $f5,$f0				#stores the user input -f5-
	
	# prompts user to enter Tolerance
	li	$v0, 4				#syscall code to print string
	la	$a0, promptT			#loads addr of promptT in $a0
	syscall					#executes prompt	
	li	$v0,6				#reads user input for tolerance
	syscall					#reads input for Tolerance into $f0
	mov.s	$f6,$f0				#stores the user input -f6-
	
	#prints table
	li	$v0, 4				#syscall code to print string
	la	$a0, outputTable		#loads addr of outputTable in $a0
	syscall					#executes prompt
	
CalculateValues:		
	
	jal 		findsMidPoint		#jumps to findsMidPoint method
	mov.s		$f9,$f0			#saves return value from --$f0-- into temporary register --$f9--
	
	mov.s		$f12, $f4		#moves value of point a into $f12 passsing the value
	jal		findFvalue		#jumps to findFvalue method
	mov.s 		$f17, $f0		#saves f(a) value into $f10
	
	mov.s		$f12, $f5		#moves value of point b into $f12 passsing the value
	jal		findFvalue		#jumps to findFvalue method
	mov.s 		$f11, $f0		#saves f(b) value into $f11
	
	mov.s		$f12, $f9		#moves value of midpoint into $f12 passsing the value
	jal		findFvalue		#jumps to findFvalue method
	mov.s 		$f16, $f0		#saves f(midpoint) value into $f16

showsinfo:
	li		$v0, 4			#syscall code to print string
	la		$a0, newLine		#loads addr of newLine in $a0
	syscall					#executes prompt

	mov.s		$f13, $f4		#saves point a into $f13 to pass it
	jal		printValues		#jumps to the method printValues

	mov.s		$f13, $f5		#saves point b into $f13 to pass it
	jal		printValues		#jumps to the method printValues

	mov.s		$f13, $f9		#saves midpoint into $f13 to pass it
	jal		printValues		#jumps to the method printValues
	
showsFvalues:
	mov.s		$f13, $f17		#saves f(a) into $f13 to pass it
	jal		printValues		#jumps to the method printValues

	mov.s		$f13, $f11		#saves f(b) into $f13 to pass it
	jal		printValues		#jumps to the method printValues

	mov.s		$f13, $f16		#saves f(midpoint) into $f13 to pass it
	jal		printValues		#jumps to the method printValues		

#checks if fa = 0 or fb = 0
	li	 	$t0, 0			#loads number 0 into $t0
	mtc1 		$t0, $f10		#stores the number as a float
	cvt.s.w 	$f19, $f10		#converts number to float and stores it in register $f19	
	
	
	c.eq.s		$f17, $f19		#compares if f(a)= 0
	bc1t		exit			#stop program if f(a) = 0

	c.eq.s		$f11, $f19		#compares if f(b)= 0
	bc1t		exit			#stop program if f(b) = 0

calctolerance:					# calcualte tolerance;
	sub.s		$f20, $f5,$f4		# calcualte tolerance b-a saves into f20
	
	c.lt.s		$f20, $f6		#sets flag true if interval is less than tolerace
	bc1t		finalExit		#if the interval is less than the toleracen branch to FinalExit
	

	mul.s		$f18, $f16, $f11	#multiplys f(mdpt) * f(b) saves in $f18
	
	c.lt.s		$f18, $f19		#sets flag true if f(mdpt) * f(b) < 0
	bc1t		else			#if true branches to else
	
	#then root = [a, midpoint]
	mov.s		$f5, $f9		#moves the f(midpoint) into value
	j		CalculateValues		#jumps to calculatevalues method
	
else:   #in which root = [midpoint,b]
	mov.s		$f4, $f9		#a = new midpoint
	j		CalculateValues		#jumps to calculatevalues method

finalExit:

	li		$v0, 4			#syscall code to print string
	la		$a0, newLine		#loads addr of newLine in $a0
	syscall					#executes prompt	
	
	li		$v0, 2			#syscall code to print float number
        mov.s		$f12,$f9		#moves value of $f4 into register f$12
        syscall					#prints value
		
	li		$v0, 10			#system call code to exit program
	syscall					#executes 
	
findsMidPoint:       
						#converts 2 into float
	li	 	$t0, 2			#loads number 2 into $t0
	mtc1 		$t0, $f10		#stores the number as a float
	cvt.s.w 	$f8, $f10		#converts number to float and stores it in register $f8

        add.s		$f7,$f5,$f4		#adds points together b+a
        div.s 		$f7,$f7,$f8		#divdes the sum by 2.0 and-- stores the mid point in $f7
        mov.s		$f0,$f7			# return function $f0 = ($f7 = midpoint)
        jr		$ra			#jumps to back to main
        
findFvalue:
	mul.s		$f7, $f12, $f12		#multiplies the value x value
	mul.s		$f7, $f7, $f12		#multiplies the original value by the saved value for x^3
	sub.s 		$f7, $f7, $f12		#subtracts the x^3 value by x
	
	li	 	$t0, 1			#loads number 1 into $t0
	mtc1 		$t0, $f10		#stores the number as a float
	cvt.s.w 	$f8, $f10		#converts number to float and stores it in register $f8
	
	sub.s 		$f7, $f7, $f8		#subtracts the new value by 1 
	
	mov.s		$f0, $f7		# return function value = x^3 - x - 1
	jr		$ra			#jumps back to main
	        
printValues:
	li		$v0, 2			#syscall code to print float number
        mov.s		$f12,$f13		#moves value of $f13 into register f$12
        syscall					#prints value
	
	li		$v0, 4			#syscall code to print string
	la		$a0, spaceTabs		#loads addr of spacetabs in $a0
	syscall					#executes prompt
	
	jr		$ra			#returns to  main

exit:
	li	$v0, 10				#system call code to exit program
	syscall					#executes 
 
