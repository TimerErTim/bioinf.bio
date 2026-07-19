#import "/src/lib.typ": metro-setup, qty
#set page(width: auto, height: auto)


#box(width: 3cm)[
  Some filler text #qty(10, "m")\
  #metro-setup(allow-quantity-breaks: true)
  Some filler text #qty(10, "m")
]
