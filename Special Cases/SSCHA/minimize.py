import sscha, sscha.Ensemble, sscha.SchaMinimizer
import sscha.Utilities
import cellconstructor as CC, cellconstructor.Phonons

POPULATION = 1

dyn = CC.Phonons.Phonons("dyn_start_population1_", 3)
ensemble = sscha.Ensemble.Ensemble(dyn, 0)
ensemble.load("data", population = POPULATION, N = 100)

minim = sscha.SchaMinimizer.SSCHA_Minimizer(ensemble)
minim.init()

# Save the minimization details
ioinfo = sscha.Utilities.IOInfo()
ioinfo.SetupSaving("minim_{}".format(POPULATION))


minim.run(custom_function_post = ioinfo.CFP_SaveAll)
minim.finalize()
minim.dyn.save_qe("final_sscha_dyn_population{}_".format(POPULATION))

