# Basic Intro #
# Created by Rylon Ma during Aug 20th to Aug 24th
# considering calculating in MIPS requires complicated stack operation, only deal with expression 
# without the '(' or ')' in the string which will be read through the buffer
# nor supporting the '3/-2' format as well considering the '-' will be error-order input
# the operation mainly focuses on three parts, 
# 1. to deal with the input string
# 2. to push and pop in the simulator of stack
# 3. to calculate
# the main calculation will turn every step of mul and div into number result
# then add all the results in total
# if negative then give minus situation into stack!
# TEXT SEGMENT #
.text
 .include "M1550276.asm" 
.globl	main
main:
##############instru string print##############
li	$v0,	4
la	$a0,	instru_str
syscall
##############instru string print##############
##############Read input##############
li	$v0,	8 #syscall num
la	$a0,	buffer #address load
li	$a1,	30 #length
move	$t0,	$a0	#store str in $t0
la	$s6,	buffer
syscall
##############Read input##############
####TEST
#addi	$s6,	$s6,	2
#lb	$a0,	($s6)
#li	$v0,	11
#syscall
#j	END
####TEST
##############Loop pro##############
# params intro:
# @$t0,addr of str input
# @$t1,to read in tmp
# @$t2,temp store for in_read
# @$t3,to store the mod after div
# @$s0,signal of every step of judge
# @$s1,$s2,reg to restore the result, but only $s2 inuse unless mul to hi in $s1
# generally used in div for 1st behind.
# @$s3,the opj
# @$s4,the num to be oped
# @$s5,the signal, +1 OR -1
# @$s6,iterator,INC in every loop to point to the charAt
# @$s7,to remember how much in stack
# @$sp,$fp,stack pointer
move	$s6,	$t0
pre_do1:
li	$t2,	0
li	$s1,	0
li	$s3,	0
li	$s4,	0
li	$s7,	0
gene_loop:
####
#print_int($s4)
pre_do2:
li	$s0,	0
####
jal	read_ops
beq	$s0,	5,	end_input
jal	read_num
beq	$s0,	-2,	err_print
#number GOT!
beq	$s3,	'+',	add_perform
beq	$s3,	'-',	sub_perform
beq	$s3,	'*',	mul_perform
beq	$s3,	'/',	div_perform
####add 
add_perform:
li	$s5,	1
mul	$s4,	$s4,	$s5 #signal posi
mflo	$s4
addi	$sp,	$sp,	-4
sw	$s4,	($sp) #input integer
addi	$sp,	$sp,	-4
sw	$s1,	($sp) #input dotposi
addi	$s7,	$s7,	2
li	$s1,	0 #!impotant! set zero!
j	next_loop
####sub
sub_perform:
li	$s5,	-1
mul	$s4,	$s4,	$s5 #signal neg
mflo	$s4
addi	$sp,	$sp,	-4
sw	$s4,	($sp) #integer into stack
addi	$sp,	$sp,	-4
sw	$s1,	($sp)
addi	$s7,	$s7,	2 #dot posi
li	$s1,	0 #!impotant! set zero!
j	next_loop
####mul
mul_perform:
lw	$s1,	($sp)
addi	$sp,	$sp,	4 #get dot posi
lw	$t2,	($sp)
addi	$sp,	$sp,	4 #get integer
move	$t1,	$s4
mul  	$s4,	$s4,	$t2
mflo	$s4
mul	$s1,	$t1,	$s1
mflo	$s1
addi	$sp,	$sp,	-4
sw	$s4,	($sp)
addi	$sp,	$sp,	-4
sw	$s1,	($sp)
li	$s1,	0
#lw	$t2,	($sp)
#print_int($t2)
j	next_loop
####div
div_perform:
beq	$s4,	0,	of_err
lw	$t3,	($sp)
addi	$sp,	$sp,	4
div	$t3,	$s4
mflo	$t3
#print_int($t3)
move	$s1,	$t3
lw	$t2,	($sp)
addi	$sp,	$sp,	4
div	$t2,	$s4 #integer do div
mflo	$t2
mfhi	$t3
mul	$t3,	$t3,	10 #dotposi: mod*10/$s4
mflo	$t3
div	$t3,	$s4
mflo	$t3
#print_int($s1)
add	$s1,	$s1,	$t3
addi	$sp,	$sp,	-4
move	$s4,	$t2
sw	$s4,	($sp)
addi	$sp,	$sp,	-4
sw	$s1,	($sp)
li	$s1,	0
j	next_loop
next_loop:
j	gene_loop
####
##############Loop pro##############
#li	$s3,	43
#li	$s4,	23
#li	$s5,	10
#jal	op_perform
#print_int($a1)
####################################
#
end_input:
li	$s4,	0
li	$s1,	0
cal_loop:
lw	$t3,	($sp)
addi	$sp,	$sp,	4
lw	$t2,	($sp)
addi	$sp,	$sp,	4
add	$s4,	$s4,	$t2 #integer
add	$s1,	$s1,	$t3 #dotposi
subi	$s7,	$s7,	2
beq	$s7,	0,	go_rs
j	cal_loop
go_rs:
li	$t2,	10
div	$s1,	$t2
mfhi	$s1
mflo	$t2
add	$s4,	$s4,	$t2
bge	$s1,	0,	print_rs
ble	$s4,	0,	print_rs
addi	$s4,	$s4,	-1 #call for a posi lend
addi	$s1,	$s1,	10
print_rs:
li	$v0,	4
la	$a0,	result_str
syscall
print_int($s4)
li	$v0,	4
la	$a0,	dot
syscall
bge	$s1,	0,	dir_print_mod
mul	$s1,	$s1,	-1 #if mod is neg, set posi it
mflo	$s1
dir_print_mod:
print_int($s1)
END:
li     $v0, 10                    #system call code for exit = 10
syscall        #call operating system to exit
####
####              
# end of codes
# yes I leave one line to make happy!
