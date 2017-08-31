####Expression Calculation Simulator in MIPS Assembly
####Created by Rylon Ma on Aug.30th,@Tongji Univ. Please feel free to contact me through e-mail: myralon1997@163.com in case of any problems or possible improvements.
####Running Environment: MIPS simulator mars4.4 or higher.
Adapted for any kind of PCs. 
####Brief Instructions:
In order to calculate the input mathematics expression, please open the three .asm files simultaneously. Since mars4.4 supports ‘.include”*.asm”’ functions, you don’t need to operate any Link procedures.
The main segment is in the L1550276.asm, so open it as the current file. Click the icon which alike a ‘wrench’ to assemble it， then run the program and follow the instructions on the I/O window.
After seeing the words like:” Please input the expression, () is not supported yet.S=”, please input the expressions and press the enter button to calculate.
The window will then give the answer of your expression.
Considering errors may occur, a single-step debug method is suggested to help find the problem. The UI window has been managed to show friendliness, and steps simplified. 
####Formats required for the input expression:
1. Restricted by my personal capability and time, ‘(’and‘)’ is not supported yet. Please put numbers in order, divide and multiply primer to add and subtract.
2. Every time in a loop procedure, a operator and a number is read in. Thus a ‘-’ is only accepted after a number or at the beginning of the expression. For example, ‘-3*5+2-1’ is accepted, but ‘3+6/-2*5’ will report a error since the ‘-’ is behind a ‘/’ instead of a number.
3. ‘ ’(a blank) or the enter button pressed will be considered as the end of the input expression.
*Error information:
1. Please finish your expression with a number, otherwise it will remind you that input string is not finished.
2. Please kindly note that result of each step should be under the 9,999 and above -9,999, otherwise result will be incorrect, including a ‘0’ divide any number causing overflow.
####Again for your information, for any problems or possible improvements, feel free to contact me through my e-mail provided above.
Hope you enjoy it!
