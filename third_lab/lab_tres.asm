# ACyLab
# For lab # 3
# File handling in MIPS

# Este programa abre un archivo de texto plano, lo lee, pide al usuario un  numero
# de palabras y luego le dice cuantas concurrencias hay  de C/U

.data
file_in:	.asciiz "/home/juan/U/test.java" # Reemplace esta cadena con el nombre del archivo que desea abrir para ser leido
file_out:	.asciiz "output.txt"	         # Este es el nombre del archivo de salida
pet1:           .asciiz "Ingrese la cadena a buscar o ° para salir "
pet2:           .asciiz "Ingrese la siguiente cadena o ° para salir "
pet3:           .asciiz "cerrando sin ninguna cadena"
pet4:           .asciiz "cerrando con al menos una cadena"

texto:          .space      2000        # space for text
cadena:         .space      50           # space for string


.text

main:

# Open (for reading) a file
	li $v0, 13		# System call for open file
	la $a0, file_in		# Input file name
	li $a1, 0		# Open for reading (flag = 0)
	li $a2, 0		# Mode is ignored
	syscall			# Open a file (file descriptor returned in $v0)
	move $s0, $v0		# Copy file descriptor


# Read from previously opened file
	li $v0, 14		# System call for reading from file
	move $a0, $s0		# File descriptor
	la $a1, texto	        # Address of input buffer
	li $a2, 2000		# Maximum number of characters to read
	syscall			# Read from file
	move $s1, $v0		# Copy number of characters read
	

	
# Close the files
  	li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file
	
	
# prints what in the file

	li $v0, 4
	la $a0, texto
	syscall
	
	
preguntar:	
#Se le pide al usuario que por favor ingrese la palabra a buscar	
	li $v0, 4
	la $a0, pet1
	syscall
	
#Se captura la cadena que el usuario ingresa	
	li $v0, 8
	la $a0, cadena
	li $a1, 50
	syscall
	
# Se muestra la cadena que el usuario ingresa	
        li $v0, 4
	la $a0, cadena
	syscall
	
	lbu $t5, 0($a0)
	beq $t5, 248, terminarp   # comprobacion para saber si  el usuario metio un ° 248 es el numero ascci cerrando sin ninguna cadena
	
	la $t1, texto             # direccion en memoria del caracter en la primera posicion del texto
	la $t2, cadena            #direccion en memoria del caracter en la primera posicion de la cadena
	addi $t0, $t0, 0          #Este es el contador inicializado en 0
	
	
ciclo:
	lbu $t3, 0($t2)       #Caracter en la posicion t1 perteneciente a la cadena
	lbu $t4, 0($t1)       #Caracter en la posicion t2 perteneciente al texto
	
	bne $t4, $zero, preguntar # si el puntero del texto llegpo a final termine el programa
	
	beq $t3,$t4 addcont # este salto es el de la linea 47 del java, cuando ambos caracteres se comparan si son iguales se suma a los punteros
	
	addi $t1,$t1,1
	and $t2, 0
	j else	
	
# se reinicia el apuntador de la cadena y se aumenta el apuntador del texto
addcont:
	addi $t1,$t1,1	      # le sumo a los contadores ya que los caracteres son diferentes
	addi $t2,$t2,1	
else:	
	


	bne $t2, $zero,condicion1 # reinicio el apuntador de la cadena y agrego al contador de la primera ocurrencia de la palabra
	and  $t2,0
	addi $t0,$t0,1
	
condicion1:

	bne $t4, $zero, ciclo    # esta linea para saber si el puntero del texto ya está en el final
	#Si son iguales, o sea si está en el final del texto
	#Se debe imprimir la palabra en el documento y tambien el contador
	
#se reinicia el apuntador de la cadena porque se encontró ya una palabra y se aumenta el contador con una ocurrencia

	
	#Se pide luego una nueva palabra
	
#Se le pide al usuario que por favor ingrese la palabra a buscar	
	li $v0, 4
	la $a0, pet2
	syscall
	
#Se captura la cadena que el usuario ingresa	
	li $v0, 8
	la $a0, cadena
	li $a1, 50
	syscall
	
	
	beq $a0, 248, gen_output  # comprobacion para saber si  el usuario metio un ° 248 es el numero ascci
	
	la $t1, cadena            # direccion en memoria del caracter en la primera posicion de la cadena
	and $t1, 0                # reinicio los contadores
	and $t2, 0                # ya que se ingreso una nueva palabra


gen_output:
	#Aqui se debe generar el output






	
	
	
#Si el usuario digita ° entonces el programa de una se termina	
terminarc:
	li $v0, 4
	la $a0, pet4
	syscall
	
	#Si el usuario digita ° entonces el programa de una se termina	
terminarp:
	li $v0, 4
	la $a0, pet3
	syscall
	
	
	



	










