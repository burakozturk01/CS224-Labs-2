	.text
	addi $v0, $zero, 0x0005
	addi $v1, $zero, 0x000C
	addi $a3, $v1, 0xFFF7
	or $a3, $a3, $v0
	and $a1, $v1, $a0
	add $a1, $a1, $a0
	beq $a1, $a3, 0x000A
	slt $a0, $v1, $a0
	beq $a0, $zero, 0x0001
	addi $a1, $zero, 0x0000
	slt $a0, $a3, $v0
	add $a3, $a0, $a1
	sub $a3, $a3, $v0
	sw $a3, 0x0044($v1)
	lw $v0, 0x0050($zero)
	j 0x0000011
	addi $v0, $zero, 0x0001
	sw $v0, 0x0054($zero)
	j 0x0000012