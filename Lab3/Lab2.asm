	.text
main:	
	# Ask user for dividend
	
	li $v0, 4
	la $a0, dividendMsg
	syscall
	
	li $v0, 5
	syscall
	
	# s0, a0: Dividend
	move $s0, $v0
	
	blt $s0, $0, quit
	
	# Ask user for divisor
	
	li $v0, 4
	la $a0, divisorMsg
	syscall
	
	li $v0, 5
	syscall
	
	# s1, a1: Divisor
	move $s1, $v0
	
	move $a0, $s0
	move $a1, $s1
	
	jal RecursiveDivision
	
	# s2: Quotient
	move $s2, $v0
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, divideSign
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall

	li $v0, 4
	la $a0, equalSign
	syscall
	
	blt $s2, $0, divByZero
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	j main
	
quit:	li $v0, 10
	syscall
	
divByZero:
	li $v0, 4
	la $a0, divByZeroError
	syscall
	
	j main
	
RecursiveDivision:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	beq $a1, $0, error
	
	bgt $a0, $a1, continue
	
	li $v0, 0
	j skip
	
continue:
	sub $a0, $a0, $a1
	
	jal RecursiveDivision
	
	addi $v0, $v0, 1
	j skip

error:
	li $v0, -1

skip:	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

	.data
dividendMsg:
	.asciiz "\nDividend (negative to quit): "
divisorMsg:
	.asciiz "\nDivisor: "
	
divByZeroError:
	.asciiz "Division by zero error\n"
divideSign:
	.asciiz " / "
equalSign:
	.asciiz " = "
	
newLine:
	.asciiz "\n"