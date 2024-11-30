def @09846 render_bitmap
org 0xe902
setlr
DI,RT
pop er2 (adr xy)
er0=[er2],r2 = 9,rt
pop er2( 08 08 )
render_bitmap
render.ddd4
adr pic


pic:
hex 18 18 3C E7 E7 3C 18 18
xy:
hex 00 00