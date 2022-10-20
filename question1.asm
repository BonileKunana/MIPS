.data
    .align 2
array:      .space  200
size:       .word   20
string:     .space  20000 
op:         .asciiz "Enter n, followed by n lines of text:\n"
text:       .asciiz "The values are:\n"

    .text
   
main:
    # prompt user to enter number of strings
    li      $v0,4
    la      $a0,op
    syscall
    # read in array count
    li      $v0,5
    syscall
    addi    $s0,$v0,0           # $v0 contains the integer we read

    add     $t0,$zero,$zero     # index of array
    addi    $t1,$zero,1         # counter=1
    la      $s2,string          # load address of string storage area

read_string:
    bgt     $t1,$s0,L1          # termination point
    # get the string
    move    $a0,$s2             # place to store string
    li      $a1,20
    li      $v0,8
    syscall

    # put string into array
    sw      $a0,array($t0)

    addi    $t0,$t0,4           # increment pointer array
    addi    $t1,$t1,1           # increment count
    addi    $s2,$s2,20          # increment to next string area

    j       read_string

#### start printing the array 
L1:
    mul $t8, $s0,4
    mflo $t6
    sub $t6, $t6, 4
    add     $t0,$zero,$t6    # index of array
    addi    $t1,$zero,1         # counter = 1
    # print the title
    la      $a0,text
    li      $v0,4
    syscall
    #Start printing out strings
while:
    bgt     $t1,$s0,done        # more strings to output?  if no, fly
    lw      $t2,array($t0)      # get pointer to string
    # output the string
    li      $v0,4
    move    $a0,$t2
    syscall
    sub     $t0,$t0,4           #increment array index
    addi    $t1,$t1,1           #incremwnt count
    j       while
# program is done
done:
    li      $v0,10
    syscall
