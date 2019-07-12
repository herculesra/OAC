	.file	"main.c"
	.option nopic
	.text
	.align	2
	.globl	main
	.type	main, @function
;Começo do Programa para calcular a velocidade ideal para uma viagem
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts			; Escreve a MSG pedindo para o usuário inserir os KM
	addi	a1,sp,12
	lui	s0,%hi(.LC1)
	addi	a0,s0,%lo(.LC1)
	call	scanf			; Faz a chamada para ler os KM que o usuario vai digitar
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2) ; guarda no registrador a0 os KM
	call	puts			; Escreve a MSG pedindo para o usuário inserir o tempo desejado para percorrer essa distância.
	addi	a1,sp,8
	addi	a0,s0,%lo(.LC1) 
	call	scanf			; Faz a chamada para ler o tempo em minutos que o usuario vai digitar
	lw	a1,8(sp)
	lw	a0,12(sp)
	call	velocidadeIdeal	; Faz a chamada para o cálculo da velocidade
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Insira a distancia ate o local que deseja ir, em KM: "
	.zero	2
.LC1:
	.string	"%d"
	.zero	1
.LC2:
	.string	"Insira o tempo que tem disponivel para viagem, em Minutos: "
	.ident	"GCC: (GNU) 8.3.0"
