	.file	"velocidadeIdeal.c"
	.option nopic
	.text
	.globl	__divsi3
	.align	2
	.globl	velocidadeIdeal
	.type	velocidadeIdeal, @function

velocidadeIdeal:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	slli	a5,a0,5
	sub	a5,a5,a0	; realiza uma subtração com o conteudo de a5 e a0 e armazena em a5
	slli	a5,a5,2	; 
	add	a0,a5,a0
	slli	a0,a0,3
	lui	a5,%hi(distanciaMetros)
	sw	a0,%lo(distanciaMetros)(a5) ;guarda a distancia em metros no reg a0
	slli	a5,a1,4
	sub	a1,a5,a1
	slli	a1,a1,2
	lui	a5,%hi(tempoSegundos)
	sw	a1,%lo(tempoSegundos)(a5)  ;guarda o tempo em seg no reg a1
	call	__divsi3
	mv	a1,a0
	lui	s0,%hi(velocidade) ; Pega a velocidade do registrador especial hi
	sw	a0,%lo(velocidade)(s0) ; guarda em a0 o resultado da divisão
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)	; guarda a MSG em a0
	call	printf ;Mostra MSG da velocidade aproximada necessária
	lw	a4,%lo(velocidade)(s0) ; Coloca a velocidade calculada no registrador a4
	li	a5,31	; faz um ADDI para a5 colocando 31 no seu conteudo e já carregando ele
	bgt	a4,a5,.L4	;Caso a velocidade seja maior que 31 ele faz o brach para o .L4
.L2:
	lui	a5,%hi(velocidade)
	lw	a0,%lo(velocidade)(a5)
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra

.L4:
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts	; Mostra MSG de cuidado, caso a velocidade ultrapasse 31 metros/segundos
	j	.L2
	; Definindo as variáveis
	.size	velocidadeIdeal, .-velocidadeIdeal
	.comm	velocidade,4,4
	.comm	tempoSegundos,4,4
	.comm	distanciaMetros,4,4
	.comm	tempo,4,4
	.comm	distancia,4,4
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Velocidade necessaria: Aproximadamente %d m/s\n"
	.zero	1
.LC1:
	.string	"Cuidado isso eh muito rapido!"
	.ident	"GCC: (GNU) 8.3.0"

; Informações adicionais
; hi e lo são registradores especiais usados para armazenar o conteudo da multiplicação e divisão
; seu conteudo pode ser acessado por mfhi e mflo
