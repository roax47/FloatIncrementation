.686
.model flat

public _dodaj_jeden
.data
wykladnik dd ?
.code 


_dodaj_jeden PROC
	
	push ebp
	mov ebp,esp

	push ebx
	push ecx 
	push esi
	push edi

;float >1
	mov edi,[ebp+8]

	mov eax,edi ; kopia 1

	shl edi,9
	shr edi,9;mantysa
	bts edi,23;ustaw jawna jedynke

	shr eax,23 ;wykladnik+bias 1
	cmp eax,127
	jae wieksza_od_1
	
	mov ecx,127
	sub ecx,eax
	shr edi,cl

	mov eax,127
	shl eax,23
	add eax,edi
	jmp koniec
wieksza_od_1:

	mov ebx,0
	bts ebx,23

	sub eax,127
	mov ecx,eax
	shr ebx,cl

	add ebx,edi
	bt ebx,24
	jnc brak_korekty
	inc eax
	shr ebx,1

brak_korekty:
	btr ebx,23
	add eax,127
	shl eax,23
	add eax,ebx

koniec:
	push eax
	finit 
	fld dword PTR[esp]
	add esp,4


	pop edi
	pop esi
	pop ecx
	pop ebx
	pop ebp
	ret
_dodaj_jeden ENDP

END