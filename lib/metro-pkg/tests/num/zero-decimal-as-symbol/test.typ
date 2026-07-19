#import "/src/lib.typ": metro-setup, num
#set page(width: auto, height: auto)

#num[123.00]

#metro-setup(zero-decimal-as-symbol: true)

#num[123.00]

#num(zero-symbol: sym.dash.wave)[123.00]
