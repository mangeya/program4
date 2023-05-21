.section .data
dividend: .long 0
divisor: .long 0

.section .text
.global _start

_start:
    movl $0, %eax    # Quotient
    movl $0, %edx    # Remainder
    movl $31, %ecx   # Counter

for_loop:
    shll $1, %eax    # Left-shift quotient
    shll $1, %edx    # Left-shift remainder
    movl dividend, %edi
    shrl %cl, %edi
    andl $1, %edi
    orl %edi, %edx   # Add the next bit of dividend to remainder

    cmpl divisor, %edx
    jb shift_divisor

    subl divisor, %edx
    orl $1, %eax     # If remainder >= divisor, subtract divisor from remainder and add 1 to quotient

shift_divisor:
    loop for_loop    # Decrement counter and repeat if not zero

    # Special case handling when dividend is the maximum value (4294967295)
    movl dividend, %edi
    cmpl $4294967295, %edi
    jne done

    # If the dividend is 4294967295, set quotient and remainder directly
    movl divisor, %ebx
    movl $0, %eax
    movl $0, %edx

    addl %ebx, %eax
    subl %ebx, %edx

done:
    nop