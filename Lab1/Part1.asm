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
	
	# Checking array size for lower bound 1
	slt $t0, $zero, $v0
	beq $t0, $zero, init
	
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
	
	# Array pointer restored
	la   $s2, array
	
	# Printing array
	li $v0, 4
	la $a0, newL
	syscall
	
	la $a0, arr
	syscall
	
	la $a0, p1
	syscall
	
	# Print first element
	li $v0, 1
	lw $a0, ($s2)
	syscall
	
	# For size 1 arrays
	slt $t0, $v0, $s1
	bne $t0, $zero, dSkip1
	
	li $v0, 4
	la $a0, p2
	syscall
	
	j skip1
	
dSkip1:	# For normal arrays
	
	# Increment pointer
	addi $s2, $s2, 4
	
	addi $t1, $zero, 1	# Loop counter
	
	# Print other elements
print:	li $v0, 4
	la $a0, c
	syscall
	
	li $v0, 1
	lw $a0, ($s2)
	syscall
	
	addi $s2, $s2, 4
	
	addi $t1, $t1, 1
	slt $t0, $t1, $s1
	bne $t0, $zero, print
	
	li $v0, 4
	la $a0, p2
	syscall
	#Print done
	
	# Array pointer restored
	la   $s2, array
	
skip1:	# For one-long arrays
	
	la $a0, newL
	syscall
	
	# Reversing
	
	# Last element pointer
	add $t1, $zero, $zero
	add $t1, $t1, $s1
	sll $t1, $t1, 2
	add $t1, $t1, $s2
	addi $t1, $t1, -4
	
	# t2, t3: Swap temporary
	
rev:	lw $t2, ($s2)
	lw $t3, ($t1)
	
	sw $t3, ($s2)
	sw $t2, ($t1)
	
	addi $s2, $s2, 4
	addi $t1, $t1, -4
	
	slt $t0, $s2, $t1
	bne $t0, $zero, rev
	# Reversing done
	
	# Array pointer restored
	la   $s2, array
	
	# Printing reversed array
	li $v0, 4
	la $a0, newL
	syscall
	
	la $a0, rArr
	syscall
	
	la $a0, p1
	syscall
	
	# Print first element
	li $v0, 1
	lw $a0, ($s2)
	syscall
	
	# For size 1 arrays
	slt $t0, $v0, $s1
	bne $t0, $zero, dSkip2
	
	li $v0, 4
	la $a0, p2
	syscall
	
	j skip2
	
	dSkip2:	# For normal arrays
	
	# Increment pointer
	addi $s2, $s2, 4
	
	addi $t1, $zero, 1	# Loop counter
	
	# Print other elements
print2:	li $v0, 4
	la $a0, c
	syscall
	
	li $v0, 1
	lw $a0, ($s2)
	syscall
	
	addi $s2, $s2, 4
	
	addi $t1, $t1, 1
	slt $t0, $t1, $s1
	bne $t0, $zero, print2
	
	li $v0, 4
	la $a0, p2
	syscall
	#Print done
	
skip2:	# For one-long arrays
	
	# Program done
	li $v0, 10
	syscall
	
zArr:	# One element arrays:
	
	
	.data
	
array:	.space 80

size:	.asciiz "Enter array size (1-20): "
elems1:	.asciiz "Enter "
elems2:	.asciiz " integer element(s):\n"
arr:	.asciiz "Array: "
rArr:	.asciiz "Reversed array: "

newL:	.asciiz "\n"
p1:	.asciiz "["
p2:	.asciiz "]"
c:	.asciiz ", "
