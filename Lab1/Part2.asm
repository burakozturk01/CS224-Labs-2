	.text
	
	addi $s0, $zero, 20	# Max array size
	add  $s1, $zero, $zero	# User-defined array size
	la   $s2, array		# Array pointer
	
init:	# Printing message
	li $v0, 4
	la $a0, size
	syscall
	
	# Reading size
	li $v0, 5
	syscall
	
	# Checking array size for upper bound 20
	slt $t0, $s0, $v0
	bne $t0, $zero, init
	
	# Checking array size for lower bound 0
	slt $t0, $v0, $zero
	bne $t0, $zero, init
	
	# Zero array is a palindrome automatically.
	addi $t0, $v0, -1
	slt $t0, $t0, $zero
	bne $t0, $zero, isP
	
	add $s1, $zero, $v0
	# Initializing size done.
	
	li $v0, 4
	la $a0, newL
	syscall
	
	la $a0, elems1
	syscall
	
	li $v0, 1
	add $a0, $zero, $s1
	syscall
	
	li $v0, 4
	la $a0, elems2
	syscall
	
	add $t1, $zero, $zero	# Loop counter
	
read:	# Reading elements
	li $v0, 5
	syscall
	
	# Store value and shift pointer to right
	sw $v0, ($s2)
	addi $s2, $s2, 4
	
	# Increment counter
	addi $t1, $t1, 1
	
	# Loop until array full
	slt $t0, $t1, $s1
	bne $t0, $zero, read
	# Reading done.
	
	# One element arrays are palindromes automatically.
	addi $t0, $s1, -2
	slt $t0, $t0, $zero
	bne $t0, $zero, isP
	
	# Array pointer restored
	la   $s2, array
	
	li $v0, 4
	la $a0, newL
	syscall
	
	# Last element pointer
	add $t1, $zero, $zero
	add $t1, $t1, $s1
	sll $t1, $t1, 2
	add $t1, $t1, $s2
	addi $t1, $t1, -4
	
pCheck:	lw $t2, ($s2)
	lw $t3, ($t1)
	
	bne $t2, $t3, notP
	
	addi $s2, $s2, 4
	addi $t1, $t1, 4
	
	slt $t0, $s2, $t1
	bne $t0, $zero, isP
	
exit:	li $v0, 10
	syscall
	# Program done
	
	# Is palindrome message
isP:	li $v0, 4
	la $a0, isMsg
	syscall
	j exit
	
	# Not palindrome message
notP:	li $v0, 4
	la $a0, notMsg
	syscall
	j exit
	
	.data
	
array:	.space 80

size:	.asciiz "Enter array size (1-20): "
elems1:	.asciiz "Enter "
elems2:	.asciiz " integer element(s):\n"

isMsg:	.asciiz "The array is a palindrome"
notMsg:	.asciiz "The array is not a palindrome"


newL:	.asciiz "\n"
