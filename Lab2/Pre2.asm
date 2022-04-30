	.text
	
	# Get the number
	li $v0, 4
	la $a0, askNumberMsg
	syscall
	
	li $v0, 5
	syscall
	
	# s0 -> original number
	move $s0, $v0
	
	# Invoke subprogram
	move $a0, $s0
	jal switchNibbles
	
	# s1 -> switched number
	move $s1, $v0
	
	# Report result
	li $v0, 4
	la $a0, giveResultMsg
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 34
	move $a0, $s1
	syscall
	
	li $v0, 10
	syscall

switchNibbles:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, -4($sp)
	
	# $sp - 8 -> original number
	sw $a0, -8($sp)
	
	# s0 -> mask
	li $s0, 0xFFFFF0FF
	
	# First byte
	lbu $t0, -8($sp)
	move $t1, $t0
	
	srl $t0, $t0, 4
	sll $t1, $t1, 4
	
	and $t1, $t1, $s0
	or $t0, $t0, $t1
	
	sb $t0, -8($sp)
	
	# Second byte
	lbu $t0, -7($sp)
	move $t1, $t0
	
	srl $t0, $t0, 4
	sll $t1, $t1, 4
	
	and $t1, $t1, $s0
	or $t0, $t0, $t1
	
	sb $t0, -7($sp)
	
	# Third byte
	lbu $t0, -6($sp)
	move $t1, $t0
	
	srl $t0, $t0, 4
	sll $t1, $t1, 4
	
	and $t1, $t1, $s0
	or $t0, $t0, $t1
	
	sb $t0, -6($sp)
	
	# Fourth byte
	lbu $t0, -5($sp)
	move $t1, $t0
	
	srl $t0, $t0, 4
	sll $t1, $t1, 4
	
	and $t1, $t1, $s0
	or $t0, $t0, $t1
	
	sb $t0, -5($sp)
	
	# Load result to v0
	lw $v0, -8($sp)
	
	lw $ra, 0($sp)
	lw $s0, -4($sp)
	addi $sp, $sp, 12
	jr $ra
	
	.data
askNumberMsg:
	.asciiz "Enter number: "
giveResultMsg:
	.asciiz "Nibble switched number: "
newLine:
	.asciiz "\n"