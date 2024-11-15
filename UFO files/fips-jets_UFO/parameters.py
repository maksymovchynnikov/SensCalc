# This file was automatically created by FeynRules 2.3.43
# Mathematica version: 12.1.0 for Microsoft Windows (64-bit) (March 18, 2020)
# Date: Sun 10 Sep 2023 14:22:40



from object_library import all_parameters, Parameter


from function_library import complexconjugate, re, im, csc, sec, acsc, asec, cot

# This is a default parameter object representing 0.
ZERO = Parameter(name = 'ZERO',
                 nature = 'internal',
                 type = 'real',
                 value = '0.0',
                 texname = '0')

# User-defined parameters.
aEWM1 = Parameter(name = 'aEWM1',
                  nature = 'external',
                  type = 'real',
                  value = 127.9,
                  texname = '\\text{aEWM1}',
                  lhablock = 'SMINPUTS',
                  lhacode = [ 1 ])

Gf = Parameter(name = 'Gf',
               nature = 'external',
               type = 'real',
               value = 0.0000116637,
               texname = 'G_f',
               lhablock = 'SMINPUTS',
               lhacode = [ 2 ])

aS = Parameter(name = 'aS',
               nature = 'external',
               type = 'real',
               value = 0.1184,
               texname = '\\alpha _s',
               lhablock = 'SMINPUTS',
               lhacode = [ 3 ])

ymb = Parameter(name = 'ymb',
                nature = 'external',
                type = 'real',
                value = 4.7,
                texname = '\\text{ymb}',
                lhablock = 'YUKAWA',
                lhacode = [ 5 ])

ymt = Parameter(name = 'ymt',
                nature = 'external',
                type = 'real',
                value = 172,
                texname = '\\text{ymt}',
                lhablock = 'YUKAWA',
                lhacode = [ 6 ])

ymtau = Parameter(name = 'ymtau',
                  nature = 'external',
                  type = 'real',
                  value = 1.777,
                  texname = '\\text{ymtau}',
                  lhablock = 'YUKAWA',
                  lhacode = [ 15 ])

cs = Parameter(name = 'cs',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{cs}',
               lhablock = 'FRBlock',
               lhacode = [ 1 ])

cGs = Parameter(name = 'cGs',
                nature = 'external',
                type = 'real',
                value = 1,
                texname = '\\text{cGs}',
                lhablock = 'FRBlock',
                lhacode = [ 2 ])

cG = Parameter(name = 'cG',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{cG}',
               lhablock = 'FRBlock',
               lhacode = [ 3 ])

cq = Parameter(name = 'cq',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{cq}',
               lhablock = 'FRBlock',
               lhacode = [ 4 ])

cn = Parameter(name = 'cn',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{cn}',
               lhablock = 'FRBlock',
               lhacode = [ 5 ])

cv = Parameter(name = 'cv',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{cv}',
               lhablock = 'FRBlock',
               lhacode = [ 6 ])

MUq = Parameter(name = 'MUq',
                nature = 'external',
                type = 'real',
                value = 0.00216,
                texname = '\\text{MUq}',
                lhablock = 'FRBlock',
                lhacode = [ 7 ])

MDq = Parameter(name = 'MDq',
                nature = 'external',
                type = 'real',
                value = 0.00467,
                texname = '\\text{MDq}',
                lhablock = 'FRBlock',
                lhacode = [ 8 ])

MSq = Parameter(name = 'MSq',
                nature = 'external',
                type = 'real',
                value = 0.093,
                texname = '\\text{MSq}',
                lhablock = 'FRBlock',
                lhacode = [ 9 ])

MCq = Parameter(name = 'MCq',
                nature = 'external',
                type = 'real',
                value = 1.275,
                texname = '\\text{MCq}',
                lhablock = 'FRBlock',
                lhacode = [ 10 ])

MBq = Parameter(name = 'MBq',
                nature = 'external',
                type = 'real',
                value = 4.7,
                texname = '\\text{MBq}',
                lhablock = 'FRBlock',
                lhacode = [ 11 ])

MZ = Parameter(name = 'MZ',
               nature = 'external',
               type = 'real',
               value = 91.1876,
               texname = '\\text{MZ}',
               lhablock = 'MASS',
               lhacode = [ 23 ])

MTA = Parameter(name = 'MTA',
                nature = 'external',
                type = 'real',
                value = 1.777,
                texname = '\\text{MTA}',
                lhablock = 'MASS',
                lhacode = [ 15 ])

MT = Parameter(name = 'MT',
               nature = 'external',
               type = 'real',
               value = 172,
               texname = '\\text{MT}',
               lhablock = 'MASS',
               lhacode = [ 6 ])

MB = Parameter(name = 'MB',
               nature = 'external',
               type = 'real',
               value = 4.7,
               texname = '\\text{MB}',
               lhablock = 'MASS',
               lhacode = [ 5 ])

MH = Parameter(name = 'MH',
               nature = 'external',
               type = 'real',
               value = 125,
               texname = '\\text{MH}',
               lhablock = 'MASS',
               lhacode = [ 25 ])

Ms = Parameter(name = 'Ms',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{Ms}',
               lhablock = 'MASS',
               lhacode = [ 111111 ])

Ma = Parameter(name = 'Ma',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{Ma}',
               lhablock = 'MASS',
               lhacode = [ 111112 ])

Mn = Parameter(name = 'Mn',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{Mn}',
               lhablock = 'MASS',
               lhacode = [ 111113 ])

Mdp = Parameter(name = 'Mdp',
                nature = 'external',
                type = 'real',
                value = 1,
                texname = '\\text{Mdp}',
                lhablock = 'MASS',
                lhacode = [ 111114 ])

WZ = Parameter(name = 'WZ',
               nature = 'external',
               type = 'real',
               value = 2.4952,
               texname = '\\text{WZ}',
               lhablock = 'DECAY',
               lhacode = [ 23 ])

WW = Parameter(name = 'WW',
               nature = 'external',
               type = 'real',
               value = 2.085,
               texname = '\\text{WW}',
               lhablock = 'DECAY',
               lhacode = [ 24 ])

WT = Parameter(name = 'WT',
               nature = 'external',
               type = 'real',
               value = 1.50833649,
               texname = '\\text{WT}',
               lhablock = 'DECAY',
               lhacode = [ 6 ])

WH = Parameter(name = 'WH',
               nature = 'external',
               type = 'real',
               value = 0.00407,
               texname = '\\text{WH}',
               lhablock = 'DECAY',
               lhacode = [ 25 ])

Wsp = Parameter(name = 'Wsp',
                nature = 'external',
                type = 'real',
                value = 1,
                texname = '\\text{Wsp}',
                lhablock = 'DECAY',
                lhacode = [ 111111 ])

Wa = Parameter(name = 'Wa',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{Wa}',
               lhablock = 'DECAY',
               lhacode = [ 111112 ])

WN = Parameter(name = 'WN',
               nature = 'external',
               type = 'real',
               value = 1,
               texname = '\\text{WN}',
               lhablock = 'DECAY',
               lhacode = [ 111113 ])

WDP = Parameter(name = 'WDP',
                nature = 'external',
                type = 'real',
                value = 1,
                texname = '\\text{WDP}',
                lhablock = 'DECAY',
                lhacode = [ 111114 ])

aEW = Parameter(name = 'aEW',
                nature = 'internal',
                type = 'real',
                value = '1/aEWM1',
                texname = '\\alpha _{\\text{EW}}')

G = Parameter(name = 'G',
              nature = 'internal',
              type = 'real',
              value = '2*cmath.sqrt(aS)*cmath.sqrt(cmath.pi)',
              texname = 'G')

MW = Parameter(name = 'MW',
               nature = 'internal',
               type = 'real',
               value = 'cmath.sqrt(MZ**2/2. + cmath.sqrt(MZ**4/4. - (aEW*cmath.pi*MZ**2)/(Gf*cmath.sqrt(2))))',
               texname = 'M_W')

ee = Parameter(name = 'ee',
               nature = 'internal',
               type = 'real',
               value = '2*cmath.sqrt(aEW)*cmath.sqrt(cmath.pi)',
               texname = 'e')

sw2 = Parameter(name = 'sw2',
                nature = 'internal',
                type = 'real',
                value = '1 - MW**2/MZ**2',
                texname = '\\text{sw2}')

cw = Parameter(name = 'cw',
               nature = 'internal',
               type = 'real',
               value = 'cmath.sqrt(1 - sw2)',
               texname = 'c_w')

sw = Parameter(name = 'sw',
               nature = 'internal',
               type = 'real',
               value = 'cmath.sqrt(sw2)',
               texname = 's_w')

g1 = Parameter(name = 'g1',
               nature = 'internal',
               type = 'real',
               value = 'ee/cw',
               texname = 'g_1')

gw = Parameter(name = 'gw',
               nature = 'internal',
               type = 'real',
               value = 'ee/sw',
               texname = 'g_w')

vev = Parameter(name = 'vev',
                nature = 'internal',
                type = 'real',
                value = '(2*MW*sw)/ee',
                texname = '\\text{vev}')

lam = Parameter(name = 'lam',
                nature = 'internal',
                type = 'real',
                value = 'MH**2/(2.*vev**2)',
                texname = '\\text{lam}')

yb = Parameter(name = 'yb',
               nature = 'internal',
               type = 'real',
               value = '(ymb*cmath.sqrt(2))/vev',
               texname = '\\text{yb}')

yt = Parameter(name = 'yt',
               nature = 'internal',
               type = 'real',
               value = '(ymt*cmath.sqrt(2))/vev',
               texname = '\\text{yt}')

ytau = Parameter(name = 'ytau',
                 nature = 'internal',
                 type = 'real',
                 value = '(ymtau*cmath.sqrt(2))/vev',
                 texname = '\\text{ytau}')

muH = Parameter(name = 'muH',
                nature = 'internal',
                type = 'real',
                value = 'cmath.sqrt(lam*vev**2)',
                texname = '\\mu')

I1a33 = Parameter(name = 'I1a33',
                  nature = 'internal',
                  type = 'complex',
                  value = 'yb',
                  texname = '\\text{I1a33}')

I2a33 = Parameter(name = 'I2a33',
                  nature = 'internal',
                  type = 'complex',
                  value = 'yt',
                  texname = '\\text{I2a33}')

I3a33 = Parameter(name = 'I3a33',
                  nature = 'internal',
                  type = 'complex',
                  value = 'yt',
                  texname = '\\text{I3a33}')

I4a33 = Parameter(name = 'I4a33',
                  nature = 'internal',
                  type = 'complex',
                  value = 'yb',
                  texname = '\\text{I4a33}')

