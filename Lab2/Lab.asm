	.text
	
main:	
	# s0 <- Array address
	# s1 <- Array size
	# s2 <- Median
	# s3 <- Maximum
	
	
arrSize: # Get array size from user

	li $v0, 4
	la $a0, arrSizeMsg
	syscall
	
	li $v0, 5
	syscall
	
	move $s1, $v0
	
	ble $s1, $zero, arrSize
	
	# Array allocation
	
	li $v0, 9
	move $a0, $s1
	sll $a0, $a0, 2
	syscall
	
	move $s0, $v0
	
	# Monitor
	move $a0, $s0
	move $a1, $s1
	
	jal monitor
	
	move $s2, $v0
	move $s3, $v1
	
	# Display sorted array
	
	# t0 <- Array address + 4
	move $t0, $s0
	addi $t0, $t0, 4
	
	# t1 <- Address of last element
	move $t1, $s1
	sll $t1, $t1, 2
	add $t1, $t1, $s0
	
	li $v0, 4
	la $a0, openBr
	syscall
	
	li $v0, 1
	lw $a0, 0($s0)
	syscall
	
	beq $t0, $t1, skipLoop
	
dispLoop:
	li $v0, 4
	la $a0, comma
	syscall
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall
	
	add $t0, $t0, 4
	
	bne $t0, $t1, dispLoop
skipLoop:

	li $v0, 4
	la $a0, closeBr
	syscall
	
printMedMax:
	li $v0, 4
	la $a0, medianMsg
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, maxMsg
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
exit:	
	li $v0, 10
	syscall
	
monitor:
	# Save registers to stack
	addi $sp, $sp, -28
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $ra, 24($sp)
	
	# s0 <- Array address
	# s1 <- Array size
	# s2 <- Last elements address
	# s3 <- Median
	# s4 <- Maximum
	# s5 <- Temp values
	
	move $s0, $a0
	move $s1, $a1
	
	# s4 <- Address of last element
	move $s2, $s1
	sll $s2, $s2, 2
	add $s2, $s2, $s0

	
	# Fill array
	li $v0, 4
	la $a0, enterIntMsg
	syscall
	
	move $s5, $s0	# Counter
	
fillArrLoop:	
	li $v0, 5
	syscall
	
	sw $v0, 0($s5)
	
	addi $s5, $s5, 4
	
	bne $s2, $s5, fillArrLoop
	
	# Interactive menu
	j iaMenu
menuError:
	li $v0, 4
	la $a0, menuErrorMsg
	syscall
iaMenu:
	li $v0, 4
	la $a0, menuMsg
	syscall
	
	li $v0, 5
	syscall
	
	li $s2, 1
	beq $v0, $s2, bubbleChoice
	addi $s2, $s2, 1
	beq $v0, $s2, mmChoice
	addi $s2, $s2, 1
	beq $v0, $s2, monitorExit
	j menuError
	
bubbleChoice:
	move $a0, $s0
	move $a1, $s1
	
	jal bubbleSort
	
	j iaMenu

mmChoice:
	move $a0, $s0
	move $a1, $s1
	
	jal medianMax
	
	move $s3, $v0
	move $s4, $v1
	
	j iaMenu
	
monitorExit:

	move $v0, $s3
	move $v1, $s4
	
	# Restore registers from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $ra, 24($sp)
	addi $sp, $sp, 28
	
	jr $ra
	
bubbleSort:
	addi $sp, $sp, -32
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $ra, 28($sp)
	
	# s0 <- Array address
	# s1 <- Array size
	# s2 <- Temp1
	# s3 <- Temp2
	# s4 <- Temp3
	# s5 <- Temp4
	# s6 <- Temp5
	
	move $s0, $a0
	move $s1, $a1
	
	li $s2, 0 # i
forLoop1:
	li $s3, 0 # j
	forLoop2:
		sll $s3, $s3, 2
		add $s3, $s3, $s0
		
		lw $s4, 0($s3)
		lw $s6, 4($s3)
		
		ble $s4, $s6, skipSwap
		
		sw $s4, 4($s3)
		sw $s6, 0($s3)
		
		skipSwap:
		sub $s3, $s3, $s0
		srl $s3, $s3, 2
		
		addi $s3, $s3, 1
		move $s4, $s1
		sub $s4, $s4, $s2
		add $s4, $s4, -1
		blt $s3, $s4, forLoop2
	
	addi $s2, $s2, 1
	addi $s5, $s1, -1
	blt $s2, $s5, forLoop1
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $ra, 28($sp)
	addi $sp, $sp, 32
	
	jr $ra
	
medianMax:
	
	# s0 <- Array address
	# s1 <- Array size
	# s2 <- Median
	# s3 <- Max
	# s4 <- Temp
	
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $ra, 20($sp)
	
	# If array size is 1
	li $s3, 1
	bgt $a1, $s3, noShortCut
	
	lw $v0, ($a0)
	move $v1, $v0
	jr $ra
	
noShortCut:

	move $s0, $a0
	move $s1, $a1
	li $s3, 0
	
	# Median
	li $s2, 2
	div $s1, $s2
	mfhi $s2
	
	beq $s2, $zero, evenMedian
	
	mflo $s2
	sll $s2, $s2, 2
	add $s2, $s2, $s0
	
	lw $s2, ($s2)
	
	j endMedian
	
evenMedian:
	sll $s3, $s1, 1
	add $s3, $s3, $s0
	addi $s2, $s3, -4
	
	lw $s2, ($s2)
	lw $s3, ($s3)
	
	add $s2, $s2, $s3
	li $s3, 2
	div $s2, $s2, $s3
		
endMedian:

	# Maximum
	
	# s3 <- Address of last element
	move $s3, $s1
	addi $s3, $s3, -1
	sll $s3, $s3, 2
	add $s3, $s3, $s0
	
	lw $s4, ($s0)
	
findMaxLoop:
	addi $s0, $s0, 4
	lw $s1, ($s0)
	
	ble $s1, $s4, skipChangeMax
	
	move $s4, $s1
	
skipChangeMax:
	
	bne $s0, $s3, findMaxLoop
	
	move $v0, $s2
	move $v1, $s1
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, 24
	
	jr $ra
	
	.data
	
arrSizeMsg:
	.asciiz "Enter the array size (min. 1): "
	
enterIntMsg:
	.asciiz "Enter integers: "
	
medianMsg:
	.asciiz "Median: "

maxMsg:
	.asciiz "\nMaximum: "
	
menuMsg:
	.asciiz "1. Sort array\n2. Find median & max\n3. Exit\n"
	
menuErrorMsg:
	.asciiz "Invalid input\n"
	
comma:
	.asciiz ", "
openBr:
	.asciiz "\n["
closeBr:
	.asciiz "]\n"
