	.text
txtStart:
	la $a0, txtStart
	la $a1, txtEnd
	
	jal countInstructions
	
	move $s0, $v0		# R-type
	move $s1, $v1		# I-type
	
	li $v0, 4
	la $a0, rTypeMsg
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, iTypeMsg
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 10
	syscall
	
countInstructions:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	
	move $s0, $a0
	move $s1, $a1
	
	li $v0, 0	# R-type
	li $v1, 0	# I-type
	
countLoop:
	bgt $s0, $s1, countDone
	
	lw $s2, ($s0)
	srl $s2, $s2, 26
	
	beq $s2, $0, rType
	
	li $s3, 2
	beq $s2, $s3, skip
	addi $s3, $s3, 1
	beq $s2, $s3, skip
	
	j iType
rType:
	addi $v0, $v0, 1
	j skip
iType:
	addi $v1, $v1, 1
skip:
	addi $s0, $s0, 4
	j countLoop
	
countDone:
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addi $sp, $sp, 20
	
txtEnd:	jr $ra
	.data
rTypeMsg:
	.asciiz "\nNumber of R-type instructions: "
iTypeMsg:
	.asciiz "\nNumber of I-type instructions: "
