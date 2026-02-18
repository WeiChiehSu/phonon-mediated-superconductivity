import cellconstructor as CC, cellconstructor.Phonons
import sscha, sscha.Ensemble
import numpy as np

# Fix the seed so that we all generate the same ensemble
np.random.seed(0)

# Load the dynamical matrix
dyn = CC.Phonons.Phonons("start_sscha", nqirr=3)
dyn.Symmetrize()

#[ If we have imaginary phonons, remove them here ]

# Prepare the ensemble
temperature = 0 # 300 K
ensemble = sscha.Ensemble.Ensemble(dyn, temperature)

# Generate the ensemble
number_of_configurations = 100
ensemble.generate(number_of_configurations)

# Save the ensemble into a directory
save_directory = "data"
population_id = 1
ensemble.save(save_directory, population_id)

