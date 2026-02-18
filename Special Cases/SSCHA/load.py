import cellconstructor as CC, cellconstructor.Phonons

dyn = CC.Phonons.Phonons("1BL.dyn", 3)
w, p = dyn.DiagonalizeSupercell()

import sscha, sscha.Ensemble

dyn.ForcePositiveDefinite()
dyn.save_qe("start_sscha")
ensemble = sscha.Ensemble.Ensemble(dyn, 0)
ensemble.generate(100)
