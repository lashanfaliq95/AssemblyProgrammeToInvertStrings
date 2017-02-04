  .text

reverse:

sub sp,sp,#200  @getting a temperory block of memory

mov r1,sp
mov r2,#0

loop: 
     add r12,r0,r2 

     ldrb r3,[r12,#0]
     
     CMP  r3,#0

     beq  exit

     strb r3,[r1,#0]

     add r1,r1,#1
     add r2,r2,#1

     
     b loop
exit:
    sub r1,r1,#1
    sub r2,r2,#1 
     mov r1,sp
  
loop1:
     add r12,r1,r2

     ldrb r3,[r12,#0]

     cmp  r2,#0

     blt exit1

     strb r3,[r0,#0]

     add r0,r0,#1
     sub r2,r2,#1

     b loop1
exit1:

add sp,sp,#200
mov pc,lr





  .global main

 main:  
 sub sp,sp,#216
 str lr,[sp,#208]

    ldr	r0, =formatr
	bl	printf

    
	ldr	r0, =formatd
	mov	r1, sp
	bl	scanf	@scanf("%d",sp)
    

    
    
    add	r0,sp,#212        @#200 upwards
	bl	gets
    
    ldr r1,[sp,#0]  @r1=input
    cmp r1,#0
    bge exit2
    

    ldr r0,=formate  @if negative give error
    bl  printf
    ldr lr,[sp,#208] 
    add sp,sp,#212
    mov pc,lr
    
    exit2:

    cmp r1,#0        
    bne exit3
    
    
    ldr lr,[sp,#208] @if zero just end the porgram
    add sp,sp,#212
    mov pc,lr
    
    exit3:
    mov r2,#0

    loop2:
 
    cmp r1,#0     
    ble exit4
     
    sub r1,r1,#1       
    str r1,[sp,#204]  @if positive number
    str r2,[sp,#200]
    

    ldr r0,=format1 
    mov r1,r2   
    bl  printf

   
	mov	r0,sp        @#200 upwards
	bl	gets
    

    ldr r0,=formato
    ldr r1,[sp,#200]
    bl  printf
    
    
    ldr r0,=formatn
    bl printf

    mov r0,sp
    bl reverse

    mov r0,sp

    ldr r0,=formats
    mov r1,sp
    bl printf

    ldr r0,=formatn
    bl printf
    
    ldr r1,[sp,#204]
    ldr r2,[sp,#200]  
    add r2,r2,#1
    b loop2
 exit4:


 ldr lr,[sp,#208]
 sub sp,sp,#216


mov pc,lr

  .data
  formatr: .asciz "Enter the number of strings : \n"
  formatd: .asciz "%d"
  formats: .asciz "%s"
  formate: .asciz "Invalid number\n"
  format1: .asciz "Enter the input string %d : \n"
  formato: .asciz "Output string %d is :"  
  formatn: .asciz "\n"
