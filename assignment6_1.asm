; Assignment #: 6.1
; Program Description: Program that use string type key 
; to encrypt and decrypt the plain text by XOR-ing each character 
; of the key against a corresponding byte in the message.
; Author: Mariia Surmenok (student: M00232832)
; Creation Date: 11/3/2016
; Revisions: 
; Date: 11/4/2016         Modified by: Mariia Surmenok

; //include Irvine32.inc
INCLUDE Irvine32.inc
BUFMAX = 128

.data
message1 BYTE "Enter the plain text (128 symbols maximum): ", 0
message2 BYTE "Enter the encryption key (128 symbols maximum): ", 0
message3 BYTE "Cipher text: ", 0
message4 BYTE "Decrypted: ", 0
key BYTE BUFMAX+1 DUP(0)
buffer BYTE BUFMAX+1 DUP(0)
keySize DWORD ?
bufferSize DWORD ?

.code
main PROC
	;
	;read string for decription
	mov edx, OFFSET message1
	call WriteString
	mov ecx, BUFMAX
	mov edx, OFFSET buffer
	call ReadString
	mov bufferSize, eax
	call Crlf
	;
	;read key
	mov edx, OFFSET message2
	call WriteString
	mov ecx, BUFMAX
	mov edx, OFFSET key
	call ReadString
	mov keySize, eax
	call Crlf
	;
	call TranslateBuffer
	;
	;print encrypited string
	mov edx, OFFSET message3
	call WriteString
	call Crlf
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	;
	;
	call TranslateBuffer
	;
	;print encrypited string
	mov edx, OFFSET message4
	call WriteString
	call Crlf
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call WaitMsg
	exit
main ENDP
;-------------------------
TranslateBuffer PROC
;
;Translates the string by exclusive-ORing each
;byte with the byte from encryption string
;-------------------------
	pushad				;save all registers in stack
	mov ecx, bufferSize ;loop counter
	mov esi, 0			;index 0 in buffer
	mov edi, 0			;index 0 in key
L1:
	mov al, key[edi]
	xor buffer[esi], al
	inc esi
	inc edi
	;if edi == keySize -> edi = 0
	mov eax, edi
	cmp eax, keySize
	jb next
	mov edi, 0
	next:
	loop L1
	popad
	ret
TranslateBuffer ENDP
END main
