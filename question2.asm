
.data
endl: .asciiz "\n"
my_string: .asciiz "Enter a sum:\n"
second_string: .asciiz "The value is:\n"
str_end: .word 0
buffer: .space 100

    .text
    .globl main

main:
    la $a0, my_string
    li $v0, 4           #   print the string
    syscall

    #la $a0, endl        #   print endl
    #li $v0, 4
   # syscall

    #la $t0, my_string   #   load mystring to $t0
    #li $t1, 0           #   make $t1 = 0, character counter
   # lb $t2, 0($t0)      #   make $t2 point to the first character of "my_string"
    #la $t5, str_end
    
    li $v0, 8
    la $a0, buffer  # load byte space into address
    li $a1, 20      # allot the byte space for string
    syscall
    move $t8, $a0   # save string to t8
    
    #la $a1, 50
    #syscall
    #move $a0, $v0
    
    li $s7,0
    li $t4, 0
cont:
    lb $t3, 0($t8)          #   print current character
    beq $t3, 10 ,print         #   if \0 is found print and exit
    beq $t3, '+' ,cell
    mul $t4, $t4, 10
    sub $t3, $t3, '0'
    add $t4, $t4, $t3
    addi $t8, $t8, 1
    
    #move $t6, $a0
    
    #addi $t6,$t6, -48
    #add $t4, $t4, $t6

    #li $v0, 11
    #syscall

    j cont
cell:
add $s7, $s7, $t4
li $t4,0
addi $t8, $t8, 1
j cont
print:
    la $a0, second_string
    li $v0, 4           #   print the string
    syscall
    #addi $t4, $t4, 38
    add $s7,$s7, $t4
    move $a0, $s7
    li $v0, 1
    syscall
    j exit

exit:
    li $v0, 10
    syscall
