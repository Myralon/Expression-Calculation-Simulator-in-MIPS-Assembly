##############Status Constant##############
.eqv	status_err_got,	-2
.eqv	status_num_got,	1
.eqv	status_add_sub_got,	2
.eqv	status_mul_div_got,	3
.eqv	status_end_got,	5
.eqv	constant_ten,		10
##############Status Constant##############
##############Data##############
.data
buffer: .space	30
newline:	.asciiz	"\n"
dot:	.asciiz 	"."
instru_str:	.asciiz "Please input the expression, () is not supported yet.\nS="
result_str:	.asciiz	"The Result is S= "
err_str:	.asciiz  	"Error! not finished string!"
of_str:	.asciiz 	"Error! overflow!"
##############Data##############
.text
##############Output Macro##############
.macro print_int (%x)
	li $v0, 1
	add $a0, $zero, %x
	syscall
#	li	$v0,	4
#la	$a0,	newline
#	syscall
.end_macro
.macro print_nl()
	li	$v0,	4
la	$a0,	newline
	syscall
.end_macro 
##############Output Macro##############
