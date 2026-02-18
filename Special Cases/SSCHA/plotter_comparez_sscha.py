import cellconstructor as CC, cellconstructor.Phonons
import cellconstructor.ForceTensor
import ase, ase.dft

import matplotlib.pyplot as plt
import numpy as np

dyn = CC.Phonons.Phonons("harmonic_dyn", 3) # Load 3 files
dyn_sscha = CC.Phonons.Phonons("final_sscha_dyn_population1_", 3)

PATH = "GMKG"
N_POINTS = 1000

# Use ASE to get the q points from the path
band_path = ase.dft.kpoints.bandpath(PATH,
    dyn.structure.unit_cell,
    N_POINTS)

# Get the q points in cartesian coordinates
q_path = band_path.cartesian_kpts()

# Get the values of x axis and labels for plotting the band path
x_axis, xticks, xlabels = band_path.get_linear_kpoint_axis()

# Perform the interpolation of the dynamical matrix along the q_path
frequencies = CC.ForceTensor.get_phonons_in_qpath(dyn, q_path)
freq_sscha = CC.ForceTensor.get_phonons_in_qpath(dyn_sscha, q_path)

# Plot the dispersion
fig = plt.figure()
ax = plt.gca()
ax.set_title("Harmonic compare SSCHA 1BL stanene Phonon dispersion")
for i in range(frequencies.shape[-1]):
   ax.plot(x_axis, frequencies[:, i], color = 'k')
   ax.plot(x_axis, freq_sscha[:, i], color = 'r', ls="dashed")


for x in xticks:
   ax.axvline(x, 0, 1, color='k', lw=0.4) # Plot vertical lines for each high-symmetry point

# Set the labels of the axis as the Brilluin zone letters
ax.set_xticks(xticks)
ax.set_xticklabels(xlabels)

ax.set_ylabel("Frequency [cm-1]")
ax.set_xlabel("q-path")
plt.tight_layout()
plt.savefig("1BL_dispersion_compare_harmonic_and_SSCHA.png")
plt.show()
