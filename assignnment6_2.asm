; Assignment #: 6.1
; Program Description: Program that use string type key 
; to encrypt and decrypt the plaintext by XOR-ing each character 
; of the key against a corresponding byte in the message.
; Author: Mariia Surmenok (student: M00232832)
; Creation Date: 11/3/2016
; Revisions: 
; Date: 11/5/2016       Modified by: Mariia Surmenok

; //include Irvine32.inc
INCLUDE Irvine32.inc

.data
CaseTable BYTE '1'
		  DWORD Process_1
EntrySize = ($ - CaseTable)
		  BYTE '2'
		  DWORD Process_2
		  BYTE '3'
		  DWORD Process_3
		  BYTE '4'
		  DWORD Process_4
NumberOfEntries = ($ - CaseTable) / EntrySize
msg1 BYTE "Boolean AND", 10,  0
msg2 BYTE "Boolean OR", 10, 0
msg3 BYTE "Boolean NOT", 10, 0
msg4 BYTE "Boolean XOR", 10, 0
msg5 BYTE 10, "Exit program", 10, 0
;10 - is a new line character
messageGreeting BYTE "---- Boolean Calculator ----", 10, 10, 
				"1. x AND y", 10, "2. x OR y", 10, "3. NOT x", 10, 
				"4. x XOR y", 10, "5. Exit program", 10, 10,
				"Enter integer> ", 0
messageInput1 BYTE "Input the first 32-bit hexadecimal operand: ", 9, 0
messageInput2 BYTE "Input the second 32-bit hexadecimal operand: ", 9, 0
messageResult BYTE "The 32-bit hexadecimal result is: ", 9, 9, 0
input1 DWORD ?
input2 DWORD ?


.code
main PROC
	L1:
		mov edx, OFFSET messageGreeting
		call WriteString
		;read user integer
		call ReadChar ;save integer to al
		cmp al, '5'
		je exitProgram ; if integer == 5 -> exit program
		call Crlf
		mov ebx, OFFSET CaseTable
		mov ecx, NumberOfEntries
		L2:
			cmp al, [ebx]
			jne L3
			call NEAR PTR [ebx+1]
			call Crlf
			call Crlf
			jmp L4
		L3: 
			add ebx, EntrySize
			loop L2
		L4:
		jmp L1
	exitProgram:
		mov edx, OFFSET msg5
		call WriteString
		call WaitMsg
	exit
main ENDP

;-------------------------------------------------------
Process_1 PROC
;
;Prompt the user for two hexadecimal integers.
;AND them together and display the result in hexadecimal
;-------------------------------------------------------
	pushad
	mov edx, OFFSET msg1
	call WriteString
	call Crlf
	mov edx, OFFSET messageInput1
	call WriteString
	call ReadHex
	mov input1, eax
	mov edx, OFFSET messageInput2
	call WriteString
	call ReadHex
	mov input2, eax
	mov eax, input1
	and eax, input2
	;print answer
	mov edx, OFFSET messageResult
	call WriteString 
	call WriteHex ;answer already in eax
	popad
	ret
Process_1 ENDP


;-------------------------------------------------------
Process_2 PROC
;
;Prompt the user for two hexadecimal integers. 
;OR them together and display the result in hexadecimal. 
;-------------------------------------------------------
pushad
	mov edx, OFFSET msg2
	call WriteString
	call Crlf
	mov edx, OFFSET messageInput1
	call WriteString
	call ReadHex
	mov input1, eax
	mov edx, OFFSET messageInput2
	call WriteString
	call ReadHex
	mov input2, eax
	mov eax, input1
	or eax, input2
	;print answer
	mov edx, OFFSET messageResult
	call WriteString 
	call WriteHex ;answer already in eax
	popad
ret
Process_2 ENDP


;-------------------------------------------------------
Process_3 PROC
;
;Prompt the user for a hexadecimal integer. 
;NOT the integer and display the result in hexadecimal. 
;-------------------------------------------------------
pushad
	mov edx, OFFSET msg3
	call WriteString
	call Crlf
	mov edx, OFFSET messageInput1
	call WriteString
	call ReadHex
	not eax
	;print answer
	mov edx, OFFSET messageResult
	call WriteString 
	call WriteHex ;answer already in eax
	popad
ret
Process_3 ENDP

;-------------------------------------------------------
Process_4 PROC
;
;Prompt the user for two hexadecimal integers.
;Exclusive-OR them together and display the result in hexadecimal.  
;-------------------------------------------------------
pushad
	mov edx, OFFSET msg4
	call WriteString
	call Crlf
	mov edx, OFFSET messageInput1
	call WriteString
	call ReadHex
	mov input1, eax
	mov edx, OFFSET messageInput2
	call WriteString
	call ReadHex
	mov input2, eax
	mov eax, input1
	xor eax, input2
	;print answer
	mov edx, OFFSET messageResult
	call WriteString 
	call WriteHex ;answer already in eax
	popad
ret
Process_4 ENDP
END main
