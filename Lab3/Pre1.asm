	.text
main:
	la	$a0, listSizeMsg
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	blt $v0, $0, quit
	
	move	$s1, $v0		# Size of the original linked list
	move	$a0, $s1		# Argument: LL's size
	jal	createLinkedList
	move	$s0, $v0		# Return value: LL's head pointer
	
	la	$a0, originalListMsg
	li	$v0, 4
	syscall
	
	move	$a0, $s0		# Argument: LL's head pointer
	jal	printLinkedList
	
	move	$a0, $s0		# Argument: LL's head pointer
	jal	generateSortedLinkedList
	move	$s2, $v0		# Return value: Sorted LL's head pointer
	
	la	$a0, sortedListMsg
	li	$v0, 4
	syscall
	
	move	$a0, $s2		# Argument: Sorted LL's head pointer
	jal	printLinkedList
	
	j	main			# Main loops until quit
	
quit:
	li	$v0, 10
	syscall

printLinkedList:
	addi	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)

	move	$s0, $a0		# LL head pointer
	beq	$s0, $zero, emptyList
print:
	beq	$s0, $zero, stopPrint
	lw	$s1, 4($s0)

# Print value
	move	$a0, $s1
	li	$v0, 1
	syscall

	la	$a0, space
	li	$v0, 4
	syscall
	
	lw	$s0, 0($s0)
	j	print
	
emptyList:
	la	$a0, space
	li	$v0, 4
	syscall
	
stopPrint:
# Print endL
	la	$a0, endL
	li	$v0, 4
	syscall
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12
	
	jr	$ra
	
createLinkedList:
	addi	$sp, $sp, -20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)

	move	$s0, $a0		# $s0: Count of nodes to create
	blt	$s0, 1, notList		# If input isnt valid

	li	$s1, 1			# $s1: Node counter

# Allocate 8 byte for a Node
	li	$a0, 8
	li	$v0, 9
	syscall

	move	$s2, $v0		# $s2 points to the first and last node of the linked list.
	move	$s3, $v0		# $s3 now points to the list head.

# Ask user for input
	la	$a0, enterInteger
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall

	sw	$v0, 4($s2)		# Set the data part of current node

addNode:
	beq	$s1, $s0, doneCreating
	addi	$s1, $s1, 1		# Increment node counter

# Allocate 8 byte for a Node
	li	$a0, 8
	li	$v0, 9
	syscall

	sw	$v0, 0($s2)		# Connect the this node to the node pointed by $s2
	move	$s2, $v0		# $s2 now points to the new node

# Ask user for input
	la	$a0, enterInteger
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall

	sw	$v0, 4($s2)		# Set the data part of current node
	j	addNode
doneCreating:
	sw	$zero, 0($s2)		# Set the pointer part of current node to 0
	move	$v0, $s3		# Set v0 as LL head pointer
	j	endCreateList
	
notList:
	li	$v0, 0
	j	endCreateList

endCreateList:
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$s3, 16($sp)
	addi	$sp, $sp, 20

	jr	$ra

CopyLinkedList:
	addi	$sp, $sp, -24
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)
	sw	$s4, 20($sp)
	
	move	$s0, $a0		# LL head pointer
	beq	$s0, $zero, copyNotList	# If list empty, skip to end
	
# Allocate 8 byte for a Node
	li	$a0, 8
	li	$v0, 9
	syscall
	
	move	$s1, $v0		# New LL head
	move	$s4, $v0		# New LL head
	lw	$s2, 0($s0)		# Next node's address
	lw	$s3, 4($s0)		# Current node's data
	
# Set data of new LL's head
	sw	$s3, 4($s1)
	
	move	$s0, $s2		# Set s0 as new node
copyNode:
	beq	$s0, $zero, copyDone
	
# Allocate 8 byte for a Node
	li	$a0, 8
	li	$v0, 9
	syscall
	
	sw	$v0, 0($s1)		# Add the new node to the end
	move	$s1, $v0		# Set s1 to new end
	lw	$s2, 4($s0)		# Get data from orig LL's current node
	sw	$s2, 4($s1)		# Set the data to the new node
	
	lw	$s3, 0($s0)		# Next node of orig LL
	move	$s0, $s3		# Set s0 to be the new node of orig LL
	j	copyNode
copyDone:
	lw	$zero, 0($s1)		# Set last node to 0
	move	$v0, $s4		# Head of copied LL
	j	copyEnd
copyNotList:
	li	$v0, 0
	j	copyEnd
copyEnd:
	lw	$s4, 20($sp)
	lw	$s5, 24($sp)
	lw	$s6, 28($sp)
	lw	$s7, 32($sp)
	addi	$sp, $sp, 24
	
	jr	$ra

LinkedListMin:
	addi	$sp, $sp, -36
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)
	sw	$s4, 20($sp)
	sw	$s5, 24($sp)
	sw	$s6, 28($sp)
	sw	$s7, 32($sp)

	move	$s0, $a0		# LL head
	beq	$s0, $zero, empty
	move	$s1, $a0		# LL head
	move	$s6, $a0		# LL head
	
	lw	$s2, 4($s1)		# Min value in the LL
	li	$s3, 0			# Prev node
	move	$s4, $s0		# Min node
	
	lw	$s1, 0($s1)		# Move to the next node
minLoop:
	beq	$s1, $zero, minDone
	lw	$s5, 4($s1)
	
	bge	$s5, $s2, minSkip
	move	$s2, $s5		# New min value
	move	$s3, $s0		# New prev node
	move	$s4, $s1		# New min Node
minSkip:
	move	$s0, $s1		# Move to the current node
	lw	$s1, 0($s1)		# Move to the next node
	j	minLoop
empty:
	li	$v0, 0			# If empty, set return value to 0
	j	minEnd
minDone:
	bne	$s3, $zero, minSkip2
	lw	$s6, 0($s6)		# Remove min head
	move	$v0, $s6		# Return value: Updated LL head
	move	$v1, $s2		# Return value: Min value
	j	minEnd
minSkip2:

# Remove Min
	lw	$s7, 0($s4)		# Get min node's next
	sw	$s7, 0($s3)		# Set min node's next to min node's previous
	
	move	$v0, $s6		# Return value: Updated LL head
	move	$v1, $s2		# Return value: Min value
	j	minEnd
minEnd:
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$s3, 16($sp)
	lw	$s4, 20($sp)
	lw	$s5, 24($sp)
	lw	$s6, 28($sp)
	lw	$s7, 32($sp)
	addi	$sp, $sp, 36

	jr	$ra

generateSortedLinkedList:
	addi	$sp, $sp, -20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)

	move	$s0, $a0		# Head node of the original LL
	beq	$s0, $zero, sortEmptyList
	move	$a0, $s0
	jal	CopyLinkedList
	move	$s1, $v0		# Copied LL head node

	la	$a0, copiedListMsg
	li	$v0, 4
	syscall

	move	$a0, $s1		# Argument: LL head
	jal	printLinkedList
	
	move	$a0, $s1		# Argument: Copied LL head
	jal	LinkedListMin
	move	$s1, $v0		# Return value: Updated LL's head
	move	$s2, $v1		# Return value: Min value from LL
	
# Allocate 8 byte for a Node
	li	$a0, 8
	li	$v0, 9
	syscall

	move	$s0, $v0		# Head of new LL
	move	$s3, $v0		# Head of new LL
	sw	$s2, 4($s0)		# Set min data to last node's value
	addNode1:
	beq	$s1, $zero, sortedExit
	
	move	$a0, $s1		# Argument: Copied LL head
	jal	LinkedListMin
	move	$s1, $v0		# Return value: Updated LL's head
	move	$s2, $v1		# Return value: Min value from LL

# Allocate 8 byte for a Node
	li	$a0, 8
	li	$v0, 9
	syscall
	
	sw	$v0, 0($s0)		# Set current node to the new node
	sw	$s2, 4($v0)		# Add min value to the LL
	move	$s0, $v0		# Set s0 as new node
	j	addNode1
sortEmptyList:
	li	$v0, 0			# If list is empty, skip to end
	j	sortedExit2
sortedExit:
	sw	$zero, 0($s0)
	move	$v0, $s3		# Return sorted LL's head
sortedExit2:
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$s3, 16($sp)
	addi	$sp, $sp, 20
	
	jr	$ra
.data
listSizeMsg: 
	.asciiz "Enter size for the new linked list (-1 to exit):\n"
	
originalListMsg: 	
	.asciiz "Original List: "
copiedListMsg:
	.asciiz "Copied List: "
sortedListMsg: 	
	.asciiz "Sorted List: "
	
emptyListString: 
	.asciiz "List is Empty"
	
	
enterInteger: 
	.asciiz "Enter an integer:\n"
space: 	
	.asciiz " "
endL: 
	.asciiz "\n"
