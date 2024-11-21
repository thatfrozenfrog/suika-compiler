# Assembler syntax

## 1. org
Define a new code segment with the starting address. All addresses in this segment start with this address. Labels can also be used to define addresses.
```
org 0x3a3b; The starting address of this segment is 3a3b
hex .. ..
label:; The label position is 3a3c
org 0x4a4b; The starting address of this segment is 4a4b
org &label +2; The starting position of this segment is 3a3e
org & +10; The starting position of this segment is 3a4e
;Note that there should be a space after &
```
`org` followed by a curly brace indicates the insertion of a code segment, and close the curly brace to return to the previous segment.
```
org 0xd522
hex .. .. ; Here is d524
org & -8 { ; The starting position of this section is d51c (note the need for a space)
hex .. .. .. ..
}
; Here it returns to d524
```
If the two sections overlap, the compiler will merge the code, and an error will be reported if there is a conflict.
## 2. hex
```
hex 3. .. 30 43
```
Write raw hex for the compiler.

## 3. Label/address

```
#org d522
hex 33 33
loop: ;<--At this time, the address represented by the label is (0xd522+2=0xd524)
hex .. .. .. ..
adr loop ; <-- 'adr loop' will be replaced by: hex 24 d5 (d524, loop address)
adr loop 55 ; <- 0xd524+55
adr loop -2 ; <- 0xd522
adr +2 ; <-- If the label name is not written, it means starting from the current address (d52e), it will be replaced by d530

```

## 4. Function label
For all available labels, please check sym.txt
Note that all labels need to be used in separate lines
```
Example: sym.txt 115 Line:
20840 and r1, 15, sll r0, 4, or r1, r0
When you use
and r1, 15, sll r0, 4, or r1, r0
in assembly, it will be replaced by hex 40 08 .2 ..
```

```
Example 2: sym.txt line 115:
@0F746 read_key
When you use
read_key
in assembly, it will be replaced by hex 48 f7 .2 .. (Note that when the address is preceded by '@', the assembler will automatically add 2 to the address)
```

Define labels with def, such as `def @22040 diag`.

Function labels with the number of parameters: the address is followed by parentheses, and the number of bytes to pop when calling this label is written in them. Pop pc is not counted. For example, the label of pop qr0 can be written as `def 130e2(8) pop qr0`. When calling such function labels in a program, they must be followed by parentheses with the corresponding number of bytes. For example, `pop qr0 (31 32 .. .. .. 6 7. fe)`.

## 5. Using asm.py
Windows:
```
python3.exe .\asm.py xxx (the file you want to compile)
python3.exe .\asm.py xxx (the file you want to compile) -min; Output the .. in hex as is instead of automatically replacing it

```
Linux:
```
python3 ./asm.py xxx (the file you want to compile)
python3 ./asm.py xxx (the file you want to compile) -min; Output the .. in hex as is instead of automatically replacing it

```