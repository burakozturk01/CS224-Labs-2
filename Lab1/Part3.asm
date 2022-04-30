	.text
	addi $s4, $zero, 8
	addi $s5, $zero, -8
	
	# x -> $s0
	add $s0, $zero, $zero
	
	# a -> $s1
	add $s1, $zero, $zero
	
	li $v0, 4
	la $a0, msgA
	syscall
	
	li $v0, 5
	syscall
	add $s1, $zero, $v0
	
	li $v0, 4
	la $a0, newL
	syscall
	
	# b -> $s2
	add $s2, $zero, $zero
	
	li $v0, 4
	la $a0, msgB
	syscall
	
	li $v0, 5
	syscall
	add $s2, $zero, $v0
	
	li $v0, 4
	la $a0, newL
	syscall
	
	# c -> $s3
	add $s3, $zero, $zero
	
	li $v0, 4
	la $a0, msgC
	syscall
	
	li $v0, 5
	syscall
	add $s3, $zero, $v0
	
	li $v0, 4
	la $a0, newL
	syscall
	
	# Calculate b-c
	sub $t1, $s2, $s3
	
	# Calculate a*(b-c)
	mult $s1, $t1
	mflo $t1
	
calc:	# Calculate (a*(b-c)) % 8
	
	# If t1 >= 8 then subtract 8
	slt $t0, $t1, $s4
	beq $t0, $zero, sub8
	
	# If t1 <= -8 then add 8
	slt $t0, $s5, $t1
	beq $t0, $zero, add8
	
	# If 8 > t1 > -8 then t1 = (a*(b-c)) % 8
	li $v0, 4
	la $a0, msgX
	syscall
	
	li $v0, 1
	add $a0, $zero, $t1
	syscall
	
exit:	li $v0, 10
	syscall
	
add8:	addi $t1, $t1, 8
	j calc

sub8:	addi $t1, $t1, -8
	j calc
	
	.data
msgA:	.asciiz "Enter a: "
msgB:	.asciiz "Enter b: "
msgC:	.asciiz "Enter c: "
msgX:	.asciiz "x = "

newL:	.asciiz "\n"
