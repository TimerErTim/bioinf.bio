#import "/src/lib.typ": metro-setup, num
#set page(width: auto, height: auto)

// Decimal Point
#num[1.2]

#num("1.2")

$num(1.2)$

// Comma
#num[1,2]

#num("1,2")

$num(1\,2)$

// Custom
#metro-setup(input-decimal-markers: (sym.minus,))

#num[1-2]

#num("1-2")

$num(1-2)$
