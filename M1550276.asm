.text
.include "L1550276.asm" 
j	main
read_num:
#subi	$sp,	$sp,	4
#sw	$ra,	($sp)
li	$s4,	0
#li	$s0,	-1
go_loop_read:
lb	$t1,	($s6)
addi	$s6,	$s6,	1
bgt	$t1,	'9',	not_num_read
blt	$t1,	'0',	not_num_read
is_num_read:
li	$s0,	1
mul	$s4,	$s4,	10
subi	$t1,	$t1,	'0'
add	$s4,	$s4,	$t1
j	go_loop_read
not_num_read:
addi	$s6,	$s6,	-1
beq	$t1,	'\n',	end_str
beq	$t1,	' ',	end_str
beq	$t1,	0,	end_str
beq	$t1,	'+',	end_read_nums
beq	$t1,	'-',	end_read_nums
beq	$t1,	'*',	end_read_nums
beq	$t1,	'/',	end_read_nums
end_str_err:
li	$s0,	-2
jr	$ra
end_str:
#beq	$s0,	-1,	end_str_err
li	$s0,	5
jr	$ra
end_read_nums:
li	$s0,	1
jr	$ra
####
read_ops:
lb	$t1,	($s6)
addi	$s6,	$s6,	1
beq	$t1,	'+',	is_ops
beq	$t1,	'-',	is_ops
beq	$t1,	'*',	is_ops
beq	$t1,	'/',	is_ops
not_ops:
beq	$t1,	'\n',	end_str2
beq	$t1,	' ',	end_str2
beq	$t1,	0,	end_str2
subi	$s6,	$s6,	1
li	$s0,	-2
jr	$ra
is_ops:
move	$s3,	$t1
li	$s0,	1
jr	$ra
end_str2:
li	$s0,	5
jr	$ra
####
err_print:
li	$v0,	4
la	$a0,	err_str
	syscall
li     $v0, 10                    #system call code for exit = 10
syscall        #call operating system to exit
of_err:
li	$v0,	4
la	$a0,	of_str
	syscall
li     $v0, 10                    #system call code for exit = 10
syscall        #call operating system to exit
