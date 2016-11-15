; Assignment #: 7.1
; Program Description: performs simple encryption by
;rotating each plaintext byte a varying number of
;positions in different directions
; Author: Mariia Surmenok (student: )
; Creation Date: 11/14/2016
; Revisions: 
; Date: 11/15/2016    Modified by:

; //include Irvine32.inc
INCLUDE Irvine32.inc

BUFMAX = 128

.data
key SBYTE -5, 3, 2, -3, 0, 5, 2, -4, 7, 9
message1 BYTE "Please enter one plain text: ", 10, 0
message2 BYTE "The plain text after encoded: ", 10, 0
message3 BYTE "The plain text after decoded: ", 10, 0
buffer BYTE BUFMAX+1 DUP(0)
bufferSize DWORD ?

.code
main PROC
	;ask user to input string
	mov edx, OFFSET message1
	call WriteString
	;read string
	mov ecx, BUFMAX
	mov edx, OFFSET buffer
	call ReadString
	mov bufferSize, eax
	call Crlf
	call Crlf
	;encrypt string
	call EncryptBuffer
	;write encrypted string
	mov edx, OFFSET message2
	call WriteString
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	;decrypt string
	call DecryptBuffer
	;write decrypted string
	mov edx, OFFSET message2
	call WriteString
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	call WaitMsg
	exit
main ENDP
;-------------------------
EncryptBuffer PROC
;encryption by rotating each plaintext byte a varying number of
;positions in different directions  using the encryption key
;(a negative value indicates a rotation to the left and a
;positive value indicates a rotation to the right;
;-------------------------
	pushad				;save all registers in stack
	mov ecx, bufferSize ;loop counter
	mov esi, 0			;index 0 in buffer
	mov edi, 0			;index 0 in key
	L1:
		mov ebx, ecx ;save counter
		mov cl, key[edi]
		;if key is positive -> rotation to the right
		;if key is negative -> rotation to the left
		cmp cl, 0
		je positive
		jl negative
		ror buffer[esi], cl
		cmp cl, 0
		jg positive
		negative:
		rol buffer[esi], cl
		positive:
		;if edi==10 -> edi = 0
		inc esi
		inc edi
		mov eax, edi
		cmp eax, 10
		jb next
		mov edi, 0
		next:
		mov ecx, ebx
		loop L1
	popad
	ret
EncryptBuffer ENDP
;-------------------------
DecryptBuffer PROC
;encryption by rotating each plaintext byte a varying number of
;positions in different directions  using the encryption key
;(a negative value indicates a rotation to the left and a
;positive value indicates a rotation to the right;
;-------------------------
	pushad					;save all registers in stack
	mov ecx, bufferSize ;loop counter
	mov esi, 0			;index 0 in buffer
	mov edi, 0			;index 0 in key
	L1:
		mov ebx, ecx ;save counter
		mov cl, key[edi]
		;if key is positive -> rotation to the right
		;if key is negative -> rotation to the left
		cmp cl, 0
		je positive
		jl negative
		rol buffer[esi], cl
		cmp cl, 0
		jg positive
		negative:
		ror buffer[esi], cl
		positive:
		;if edi==10 -> edi = 0
		inc esi
		inc edi
		mov eax, edi
		cmp eax, 10
		jb next
		mov edi, 0
		next:
		mov ecx, ebx
		loop L1
	popad
	ret
DecryptBuffer ENDP
END main