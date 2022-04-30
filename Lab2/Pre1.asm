	.text
main:	# Print message to user
	li $v0, 4
	la $a0, askOct
	syscall
	
	# Read string
	li $v0, 8
	la $a0, octStr
	li $a1, 100
	syscall
	
	# Initiate sub-program
	# a0: Address of octal string
	la $a0, octStr
	jal convertOctalToDec
	
	move $s0, $v0
	
	# Print result
	li $v0, 4
	la $a0, prtDec
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 10
	syscall


convertOctalToDec:
	addi $sp, $sp, -16
	sw $s0,   0($sp)
	sw $s1,  -4($sp)
	sw $s2,  -8($sp)
	sw $ra, -12($sp)
	
	li $s0, 0	# Decimal number
	li $s1, 1	# Octal multiplier
	move $s2, $a0	# Will be end address
	
	# Find end of string and save to s2
	li $t1, 10	# Newline character
findEndLoop:
	lbu $t0, 0($s2)
	addi $s2, $s2, 1
	bne $t0, $t1, findEndLoop
	
	addi $s2, $s2, -1

	# Turn newline terminated string to null terminated string
	li $t1, 0
	sb $t1, 0($s2)
	
	# Check validity
	move $t2, $s2
checkValid:
	addi $t2, $t2, -1
	lbu $t0, 0($t2)
	
	bgt $t0, 55, notValid
	blt $t0, 48, notValid
	
	bne $a0, $t2, checkValid
	
	# Conversion loop
	move $t2, $s2
toDecimalLoop:
	addi $t2, $t2, -1
	lbu $t0, 0($t2)
	
	addi $t0, $t0, -48
	mul $t1, $t0, $s1
	add $s0, $s0, $t1

	sll $s1, $s1, 3
	
	bne $a0, $t2, toDecimalLoop
	
	move $v0, $s0
	
	j valid
notValid:
	li $v0, -1
valid:

	lw $s0,   0($sp)
	lw $s1,  -4($sp)
	lw $s2,  -8($sp)
	lw $ra, -12($sp)
	addi $sp, $sp, 16
	jr $ra
	
	.data
	
octStr:	.space 400
askOct:	.asciiz "Enter octal number: "
prtDec:	.asciiz "Decimal form: "
