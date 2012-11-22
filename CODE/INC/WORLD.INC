

do_punktu equ 0 ;spr.tylko do punktu swiata, nie facow

MaxWorldsObjects equ 255


WorldZet dd MaxWorldsObjects DUP (?)    ;wg.czego sortujemy objekty
WorldKol dd MaxworldsObjects DUP (?)                            ;kolejnosc rysowania objektow

;-----------------------------------------------------------------------------;
;World:         00 (dd) - is visible object
;               04 (dd) - X position in World
;               08 (dd) - Y position in World
;               12 (dd) - Z position in World
;               16 (dd) - object Number
;               20 (dd) - AngleX of Object'
;               24 (dd) - AngleY of Object
;               28 (dd) - AngleZ of Object
;               32 (dd) - adder to AngleX
;               36 (dd) - adder to AngleY
;               40 (dd) - adder to AngleZ
;               44 (dd) - type of virt'object'

extrn textury : word
