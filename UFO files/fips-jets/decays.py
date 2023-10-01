# This file was automatically created by FeynRules 2.3.43
# Mathematica version: 12.1.0 for Microsoft Windows (64-bit) (March 18, 2020)
# Date: Mon 18 Sep 2023 17:44:46


from object_library import all_decays, Decay
import particles as P


Decay_alp = Decay(name = 'Decay_alp',
                  particle = P.alp,
                  partial_widths = {(P.b,P.b__tilde__):'(3*cq**2*Ma**2*MBq**2*cmath.sqrt(Ma**4 - 4*Ma**2*MB**2))/(8.*cmath.pi*abs(Ma)**3)',
                                    (P.c,P.c__tilde__):'(3*cq**2*Ma**4*MCq**2)/(8.*cmath.pi*abs(Ma)**3)',
                                    (P.d,P.d__tilde__):'(3*cq**2*Ma**4*MDq**2)/(8.*cmath.pi*abs(Ma)**3)',
                                    (P.g,P.g):'(cG**2*G**4*Ma**6)/(128.*cmath.pi**5*abs(Ma)**3)',
                                    (P.s,P.s__tilde__):'(3*cq**2*Ma**4*MSq**2)/(8.*cmath.pi*abs(Ma)**3)',
                                    (P.u,P.u__tilde__):'(3*cq**2*Ma**4*MUq**2)/(8.*cmath.pi*abs(Ma)**3)'})

Decay_b = Decay(name = 'Decay_b',
                particle = P.b,
                partial_widths = {(P.W__minus__,P.t):'(((3*ee**2*MB**2)/(2.*sw**2) + (3*ee**2*MT**2)/(2.*sw**2) + (3*ee**2*MB**4)/(2.*MW**2*sw**2) - (3*ee**2*MB**2*MT**2)/(MW**2*sw**2) + (3*ee**2*MT**4)/(2.*MW**2*sw**2) - (3*ee**2*MW**2)/sw**2)*cmath.sqrt(MB**4 - 2*MB**2*MT**2 + MT**4 - 2*MB**2*MW**2 - 2*MT**2*MW**2 + MW**4))/(96.*cmath.pi*abs(MB)**3)'})

Decay_bl = Decay(name = 'Decay_bl',
                 particle = P.bl,
                 partial_widths = {(P.c,P.c__tilde__):'(cbl**2*Mbl**4)/(36.*cmath.pi*abs(Mbl)**3)',
                                   (P.d,P.d__tilde__):'(cbl**2*Mbl**4)/(36.*cmath.pi*abs(Mbl)**3)',
                                   (P.s,P.s__tilde__):'(cbl**2*Mbl**4)/(36.*cmath.pi*abs(Mbl)**3)',
                                   (P.u,P.u__tilde__):'(cbl**2*Mbl**4)/(36.*cmath.pi*abs(Mbl)**3)'})

Decay_dp = Decay(name = 'Decay_dp',
                 particle = P.dp,
                 partial_widths = {(P.c,P.c__tilde__):'(4*cv**2*Mdp**4)/(1233.*abs(Mdp)**3)',
                                   (P.d,P.d__tilde__):'(cv**2*Mdp**4)/(1233.*abs(Mdp)**3)',
                                   (P.s,P.s__tilde__):'(cv**2*Mdp**4)/(1233.*abs(Mdp)**3)',
                                   (P.u,P.u__tilde__):'(4*cv**2*Mdp**4)/(1233.*abs(Mdp)**3)'})

Decay_H = Decay(name = 'Decay_H',
                particle = P.H,
                partial_widths = {(P.b,P.b__tilde__):'((-12*MB**2*yb**2 + 3*MH**2*yb**2)*cmath.sqrt(-4*MB**2*MH**2 + MH**4))/(16.*cmath.pi*abs(MH)**3)',
                                  (P.t,P.t__tilde__):'((3*MH**2*yt**2 - 12*MT**2*yt**2)*cmath.sqrt(MH**4 - 4*MH**2*MT**2))/(16.*cmath.pi*abs(MH)**3)',
                                  (P.ta__minus__,P.ta__plus__):'((MH**2*ytau**2 - 4*MTA**2*ytau**2)*cmath.sqrt(MH**4 - 4*MH**2*MTA**2))/(16.*cmath.pi*abs(MH)**3)',
                                  (P.W__minus__,P.W__plus__):'(((3*ee**4*vev**2)/(4.*sw**4) + (ee**4*MH**4*vev**2)/(16.*MW**4*sw**4) - (ee**4*MH**2*vev**2)/(4.*MW**2*sw**4))*cmath.sqrt(MH**4 - 4*MH**2*MW**2))/(16.*cmath.pi*abs(MH)**3)',
                                  (P.Z,P.Z):'(((9*ee**4*vev**2)/2. + (3*ee**4*MH**4*vev**2)/(8.*MZ**4) - (3*ee**4*MH**2*vev**2)/(2.*MZ**2) + (3*cw**4*ee**4*vev**2)/(4.*sw**4) + (cw**4*ee**4*MH**4*vev**2)/(16.*MZ**4*sw**4) - (cw**4*ee**4*MH**2*vev**2)/(4.*MZ**2*sw**4) + (3*cw**2*ee**4*vev**2)/sw**2 + (cw**2*ee**4*MH**4*vev**2)/(4.*MZ**4*sw**2) - (cw**2*ee**4*MH**2*vev**2)/(MZ**2*sw**2) + (3*ee**4*sw**2*vev**2)/cw**2 + (ee**4*MH**4*sw**2*vev**2)/(4.*cw**2*MZ**4) - (ee**4*MH**2*sw**2*vev**2)/(cw**2*MZ**2) + (3*ee**4*sw**4*vev**2)/(4.*cw**4) + (ee**4*MH**4*sw**4*vev**2)/(16.*cw**4*MZ**4) - (ee**4*MH**2*sw**4*vev**2)/(4.*cw**4*MZ**2))*cmath.sqrt(MH**4 - 4*MH**2*MZ**2))/(32.*cmath.pi*abs(MH)**3)'})

Decay_hnl = Decay(name = 'Decay_hnl',
                  particle = P.hnl,
                  partial_widths = {(P.W__plus__,P.e__minus__):'((Mn**2 - MW**2)*(4*cn**2*cn1**2*Mn**2 + (4*cn**2*cn1**2*Mn**4)/MW**2 - 8*cn**2*cn1**2*MW**2))/(32.*cmath.pi*abs(Mn)**3)',
                                    (P.W__plus__,P.mu__minus__):'((Mn**2 - MW**2)*(4*cn**2*cn1**2*Mn**2 + (4*cn**2*cn1**2*Mn**4)/MW**2 - 8*cn**2*cn1**2*MW**2))/(32.*cmath.pi*abs(Mn)**3)',
                                    (P.W__plus__,P.ta__minus__):'((4*cn**2*cn1**2*Mn**2 + 4*cn**2*cn1**2*MTA**2 + (4*cn**2*cn1**2*Mn**4)/MW**2 - (8*cn**2*cn1**2*Mn**2*MTA**2)/MW**2 + (4*cn**2*cn1**2*MTA**4)/MW**2 - 8*cn**2*cn1**2*MW**2)*cmath.sqrt(Mn**4 - 2*Mn**2*MTA**2 + MTA**4 - 2*Mn**2*MW**2 - 2*MTA**2*MW**2 + MW**4))/(32.*cmath.pi*abs(Mn)**3)',
                                    (P.Z,P.ve):'((Mn**2 - MZ**2)*(4*cn**2*cn2**2*Mn**2 + (4*cn**2*cn2**2*Mn**4)/MZ**2 - 8*cn**2*cn2**2*MZ**2))/(32.*cmath.pi*abs(Mn)**3)',
                                    (P.Z,P.vm):'((Mn**2 - MZ**2)*(4*cn**2*cn2**2*Mn**2 + (4*cn**2*cn2**2*Mn**4)/MZ**2 - 8*cn**2*cn2**2*MZ**2))/(32.*cmath.pi*abs(Mn)**3)',
                                    (P.Z,P.vt):'((Mn**2 - MZ**2)*(4*cn**2*cn2**2*Mn**2 + (4*cn**2*cn2**2*Mn**4)/MZ**2 - 8*cn**2*cn2**2*MZ**2))/(32.*cmath.pi*abs(Mn)**3)'})

Decay_scalar = Decay(name = 'Decay_scalar',
                     particle = P.scalar,
                     partial_widths = {(P.b,P.b__tilde__):'((-24*cs**2*MB**2*MBq**2 + 6*cs**2*MBq**2*Ms**2)*cmath.sqrt(-4*MB**2*Ms**2 + Ms**4))/(16.*cmath.pi*abs(Ms)**3)',
                                       (P.c,P.c__tilde__):'(3*cs**2*MCq**2*Ms**4)/(8.*cmath.pi*abs(Ms)**3)',
                                       (P.d,P.d__tilde__):'(3*cs**2*MDq**2*Ms**4)/(8.*cmath.pi*abs(Ms)**3)',
                                       (P.g,P.g):'(cs**2*G**4*Ms**6)/(128.*cmath.pi**5*abs(Ms)**3)',
                                       (P.s,P.s__tilde__):'(3*cs**2*Ms**4*MSq**2)/(8.*cmath.pi*abs(Ms)**3)',
                                       (P.u,P.u__tilde__):'(3*cs**2*Ms**4*MUq**2)/(8.*cmath.pi*abs(Ms)**3)'})

Decay_t = Decay(name = 'Decay_t',
                particle = P.t,
                partial_widths = {(P.W__plus__,P.b):'(((3*ee**2*MB**2)/(2.*sw**2) + (3*ee**2*MT**2)/(2.*sw**2) + (3*ee**2*MB**4)/(2.*MW**2*sw**2) - (3*ee**2*MB**2*MT**2)/(MW**2*sw**2) + (3*ee**2*MT**4)/(2.*MW**2*sw**2) - (3*ee**2*MW**2)/sw**2)*cmath.sqrt(MB**4 - 2*MB**2*MT**2 + MT**4 - 2*MB**2*MW**2 - 2*MT**2*MW**2 + MW**4))/(96.*cmath.pi*abs(MT)**3)'})

Decay_ta__minus__ = Decay(name = 'Decay_ta__minus__',
                          particle = P.ta__minus__,
                          partial_widths = {(P.W__minus__,P.hnl):'((4*cn**2*cn1**2*Mn**2 + 4*cn**2*cn1**2*MTA**2 + (4*cn**2*cn1**2*Mn**4)/MW**2 - (8*cn**2*cn1**2*Mn**2*MTA**2)/MW**2 + (4*cn**2*cn1**2*MTA**4)/MW**2 - 8*cn**2*cn1**2*MW**2)*cmath.sqrt(Mn**4 - 2*Mn**2*MTA**2 + MTA**4 - 2*Mn**2*MW**2 - 2*MTA**2*MW**2 + MW**4))/(32.*cmath.pi*abs(MTA)**3)',
                                            (P.W__minus__,P.vt):'((MTA**2 - MW**2)*((ee**2*MTA**2)/(2.*sw**2) + (ee**2*MTA**4)/(2.*MW**2*sw**2) - (ee**2*MW**2)/sw**2))/(32.*cmath.pi*abs(MTA)**3)'})

Decay_W__plus__ = Decay(name = 'Decay_W__plus__',
                        particle = P.W__plus__,
                        partial_widths = {(P.c,P.s__tilde__):'(ee**2*MW**4)/(16.*cmath.pi*sw**2*abs(MW)**3)',
                                          (P.hnl,P.e__plus__):'((-Mn**2 + MW**2)*(-4*cn**2*cn1**2*Mn**2 - (4*cn**2*cn1**2*Mn**4)/MW**2 + 8*cn**2*cn1**2*MW**2))/(48.*cmath.pi*abs(MW)**3)',
                                          (P.hnl,P.mu__plus__):'((-Mn**2 + MW**2)*(-4*cn**2*cn1**2*Mn**2 - (4*cn**2*cn1**2*Mn**4)/MW**2 + 8*cn**2*cn1**2*MW**2))/(48.*cmath.pi*abs(MW)**3)',
                                          (P.hnl,P.ta__plus__):'((-4*cn**2*cn1**2*Mn**2 - 4*cn**2*cn1**2*MTA**2 - (4*cn**2*cn1**2*Mn**4)/MW**2 + (8*cn**2*cn1**2*Mn**2*MTA**2)/MW**2 - (4*cn**2*cn1**2*MTA**4)/MW**2 + 8*cn**2*cn1**2*MW**2)*cmath.sqrt(Mn**4 - 2*Mn**2*MTA**2 + MTA**4 - 2*Mn**2*MW**2 - 2*MTA**2*MW**2 + MW**4))/(48.*cmath.pi*abs(MW)**3)',
                                          (P.t,P.b__tilde__):'(((-3*ee**2*MB**2)/(2.*sw**2) - (3*ee**2*MT**2)/(2.*sw**2) - (3*ee**2*MB**4)/(2.*MW**2*sw**2) + (3*ee**2*MB**2*MT**2)/(MW**2*sw**2) - (3*ee**2*MT**4)/(2.*MW**2*sw**2) + (3*ee**2*MW**2)/sw**2)*cmath.sqrt(MB**4 - 2*MB**2*MT**2 + MT**4 - 2*MB**2*MW**2 - 2*MT**2*MW**2 + MW**4))/(48.*cmath.pi*abs(MW)**3)',
                                          (P.u,P.d__tilde__):'(ee**2*MW**4)/(16.*cmath.pi*sw**2*abs(MW)**3)',
                                          (P.ve,P.e__plus__):'(ee**2*MW**4)/(48.*cmath.pi*sw**2*abs(MW)**3)',
                                          (P.vm,P.mu__plus__):'(ee**2*MW**4)/(48.*cmath.pi*sw**2*abs(MW)**3)',
                                          (P.vt,P.ta__plus__):'((-MTA**2 + MW**2)*(-(ee**2*MTA**2)/(2.*sw**2) - (ee**2*MTA**4)/(2.*MW**2*sw**2) + (ee**2*MW**2)/sw**2))/(48.*cmath.pi*abs(MW)**3)'})

Decay_Z = Decay(name = 'Decay_Z',
                particle = P.Z,
                partial_widths = {(P.b,P.b__tilde__):'((-7*ee**2*MB**2 + ee**2*MZ**2 - (3*cw**2*ee**2*MB**2)/(2.*sw**2) + (3*cw**2*ee**2*MZ**2)/(2.*sw**2) - (17*ee**2*MB**2*sw**2)/(6.*cw**2) + (5*ee**2*MZ**2*sw**2)/(6.*cw**2))*cmath.sqrt(-4*MB**2*MZ**2 + MZ**4))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.c,P.c__tilde__):'(MZ**2*(-(ee**2*MZ**2) + (3*cw**2*ee**2*MZ**2)/(2.*sw**2) + (17*ee**2*MZ**2*sw**2)/(6.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.d,P.d__tilde__):'(MZ**2*(ee**2*MZ**2 + (3*cw**2*ee**2*MZ**2)/(2.*sw**2) + (5*ee**2*MZ**2*sw**2)/(6.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.e__minus__,P.e__plus__):'(MZ**2*(-(ee**2*MZ**2) + (cw**2*ee**2*MZ**2)/(2.*sw**2) + (5*ee**2*MZ**2*sw**2)/(2.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.hnl,P.ve__tilde__):'((-Mn**2 + MZ**2)*(-4*cn**2*cn2**2*Mn**2 - (4*cn**2*cn2**2*Mn**4)/MZ**2 + 8*cn**2*cn2**2*MZ**2))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.hnl,P.vm__tilde__):'((-Mn**2 + MZ**2)*(-4*cn**2*cn2**2*Mn**2 - (4*cn**2*cn2**2*Mn**4)/MZ**2 + 8*cn**2*cn2**2*MZ**2))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.hnl,P.vt__tilde__):'((-Mn**2 + MZ**2)*(-4*cn**2*cn2**2*Mn**2 - (4*cn**2*cn2**2*Mn**4)/MZ**2 + 8*cn**2*cn2**2*MZ**2))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.mu__minus__,P.mu__plus__):'(MZ**2*(-(ee**2*MZ**2) + (cw**2*ee**2*MZ**2)/(2.*sw**2) + (5*ee**2*MZ**2*sw**2)/(2.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.s,P.s__tilde__):'(MZ**2*(ee**2*MZ**2 + (3*cw**2*ee**2*MZ**2)/(2.*sw**2) + (5*ee**2*MZ**2*sw**2)/(6.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.t,P.t__tilde__):'((-11*ee**2*MT**2 - ee**2*MZ**2 - (3*cw**2*ee**2*MT**2)/(2.*sw**2) + (3*cw**2*ee**2*MZ**2)/(2.*sw**2) + (7*ee**2*MT**2*sw**2)/(6.*cw**2) + (17*ee**2*MZ**2*sw**2)/(6.*cw**2))*cmath.sqrt(-4*MT**2*MZ**2 + MZ**4))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.ta__minus__,P.ta__plus__):'((-5*ee**2*MTA**2 - ee**2*MZ**2 - (cw**2*ee**2*MTA**2)/(2.*sw**2) + (cw**2*ee**2*MZ**2)/(2.*sw**2) + (7*ee**2*MTA**2*sw**2)/(2.*cw**2) + (5*ee**2*MZ**2*sw**2)/(2.*cw**2))*cmath.sqrt(-4*MTA**2*MZ**2 + MZ**4))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.u,P.u__tilde__):'(MZ**2*(-(ee**2*MZ**2) + (3*cw**2*ee**2*MZ**2)/(2.*sw**2) + (17*ee**2*MZ**2*sw**2)/(6.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.ve,P.hnl__tilde__):'((-Mn**2 + MZ**2)*(-4*cn**2*cn2**2*Mn**2 - (4*cn**2*cn2**2*Mn**4)/MZ**2 + 8*cn**2*cn2**2*MZ**2))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.ve,P.ve__tilde__):'(MZ**2*(ee**2*MZ**2 + (cw**2*ee**2*MZ**2)/(2.*sw**2) + (ee**2*MZ**2*sw**2)/(2.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.vm,P.hnl__tilde__):'((-Mn**2 + MZ**2)*(-4*cn**2*cn2**2*Mn**2 - (4*cn**2*cn2**2*Mn**4)/MZ**2 + 8*cn**2*cn2**2*MZ**2))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.vm,P.vm__tilde__):'(MZ**2*(ee**2*MZ**2 + (cw**2*ee**2*MZ**2)/(2.*sw**2) + (ee**2*MZ**2*sw**2)/(2.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.vt,P.hnl__tilde__):'((-Mn**2 + MZ**2)*(-4*cn**2*cn2**2*Mn**2 - (4*cn**2*cn2**2*Mn**4)/MZ**2 + 8*cn**2*cn2**2*MZ**2))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.vt,P.vt__tilde__):'(MZ**2*(ee**2*MZ**2 + (cw**2*ee**2*MZ**2)/(2.*sw**2) + (ee**2*MZ**2*sw**2)/(2.*cw**2)))/(48.*cmath.pi*abs(MZ)**3)',
                                  (P.W__minus__,P.W__plus__):'(((-12*cw**2*ee**2*MW**2)/sw**2 - (17*cw**2*ee**2*MZ**2)/sw**2 + (4*cw**2*ee**2*MZ**4)/(MW**2*sw**2) + (cw**2*ee**2*MZ**6)/(4.*MW**4*sw**2))*cmath.sqrt(-4*MW**2*MZ**2 + MZ**4))/(48.*cmath.pi*abs(MZ)**3)'})

