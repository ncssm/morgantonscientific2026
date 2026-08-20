---
title: "From Brain Chemistry to Computational Chemistry: Modeling Protonation and Solvation Effects on Major Neurotransmitters"
short_title: "From Brain Chemistry to Computational Chemistry"
abstract: | 
    This study focused on three major neurotransmitters: dopamine, serotonin, and epinephrine, and investigated how their molecular structures and electronic properties influenced their biological roles. This study answered the following research question: How do protonation and solvation alter the structural, energetic, and electronic properties of dopamine, serotonin, and epinephrine, and what do these changes reveal about their biological behavior and function in the central nervous system? All calculations were performed using the high school computational chemistry server, with Gaussian 16 software. Each molecular structure was geometry-optimized, verified using vibrational frequency analysis, and subsequently analyzed through molecular orbital calculations. This was repeated across solvated and protonated states. Data was collected on HOMO / LUMO values, dipole moment, and polarizability values. All calculations used the B3LYP / 6-31G(d) level of theory, except serotonin. Trends showed that protonation significantly increased dipole moment, while it decreased HOMO, LUMO and total energies across each molecule, and solvation increased polarizability. PCA and correlation analysis demonstrated results consistent with these findings. Further analysis showed that changes in dipole moment, representing structural shifts, provided a more meaningful descriptor of neurotransmitter behavior than orbital energy changes, which represent electronic changes. These patterns illustrate how small molecular interactions contribute to large-scale biological effects, such as how protonation reflects receptor - specific binding, and solvation reflects neurotransmitter release and synaptic diffusion. Together, these molecular changes demonstrate the physical functions they represent– bridging the gap between intermolecular properties and biological processes.
---

## Introduction

In the brain, various chemical messengers known as neurotransmitters transmit signals from one neuron to the next, enabling complex communication across neural circuits [@millhorn_cellular_1989]. These molecules regulate a wide range of behaviors, emotions, and cellular processes, making them essential to nearly every physiological function and reaction. This study focused on three major neurotransmitters: dopamine, serotonin, and epinephrine, and investigated how their molecular structures and electronic properties influence their biological roles. Neurotransmitters function in three main steps [@noauthor_neurotransmitters:_nodate]. First, the releasing neuron receives an electrical signal from either the brain or a sensory receptor. Then, this electrical signal is processed and converted into a chemical signal. This triggers the release of the specific neurotransmitter across a nerve synapse. Neurotransmitter vesicles move to the axon terminal, where they fuse with the cell membrane, and their contents are released into the synaptic space to be diffused across the synaptic cleft. The neurotransmitters will then bind to the appropriate receptor on the receiving neuron, and the signal will either be passed on to the next structure, or the desired effect will be initiated. The neurotransmitters themselves will face one of three outcomes: they may go through a re-uptake process, so they can be reused by the releasing neuron; they may diffuse into the extracellular space; or they may be broken down by specialized enzymes for recycling. Then, the process starts all over again, allowing biological communication to spread throughout the brain and body.

@Figure_1 depicts the path of a neurotransmitter across a nerve synapse.


``` {figure} images/browning_fig_1.png
:name: Figure_1
:align: center

Cellular Pathway of Neurotransmitters
```

The reactions of each neurotransmitter may be similar in how they occur, but their effects can differ widely. Dopamine [@jha_structural_2018] regulates movement control, motivation, and learning through receptor- and hormone - mediated signaling pathways [@urban_conformational_1993; @goode-romero_new_2020]. Serotonin [@srivastava_eosin_2017] contributes to sleep regulation, memory formation, and mood stabilization, partly because it serves as the biochemical precursor to melatonin, and because it also controls hormone pathways [@nchouwat_ndumgouo_pattern_2025]. Epinephrine affects memory consolidation alertness, and the sympathetic nervous system’s “flight or fight” response by activating the hypothalamus and adrenal receptors. Abnormal concentrations of any of these neurotransmitters can cause diseases /disorders such as Alzheimer’s, depression, or cardiovascular issues.

The functions of these neurotransmitters were strongly dependent on their molecular structure, protonation state, and ability to interact with surrounding environments [@sheffler_physiology_2026]. Dopamine consists of a benzene ring with two hydroxyl groups and a flexible amine group. It is highly water soluble when protonated but nearly non-water soluble, though more reactive, in its neutral form. Serotonin contains an indole ring (functional group), a hydroxyl group, and an amine side chain. This gives it full water solubility in its protonated form and partial water solubility when neutral.

Epinephrine includes a substituted benzene ring, two hydroxyl groups, and an ethylamine side chain. This makes it fully water soluble when protonated and nearly fully water soluble even in its neutral state. None of these molecules cross the blood-brain barrier efficiently due to their high polarity and extensive hydrogen-bonding capacities. Additionally, all three molecules form hydrogen bonds through their hydroxyl groups and bind to biological receptors through electron and functional group interactions. Together, these structural features influence solubility, reactivity, receptor specificity, and overall biological behavior.

@Figure_2 depicts the basic molecular structures of
dopamine, serotonin, and epinephrine [@sheffler_physiology_2026-1; @pubchem_dopamine_nodate; @pubchem_serotonin_nodate].

``` {figure} images/browning_fig_2.png
:name: Figure_2
:align: center

Molecular Structures of Dopamine, Serotonin, and Epinephrine
```

To investigate how protonation and solvation influence their electronic and structural behavior, this study used the Density Functional Theory (DFT) with the B3LYP [@pubchem_epinephrine_nodate] hybrid functional [@tirado-rives_performance_2008; @pradhan_chemical_2014]. This group of methods predicts molecular behavior by approximating electron density rather than computing the full electron wavefunction. B3LYP is especially accurate when predicting the behaviors of molecular orbitals, hydrogen bonding patterns, and optimized geometries of organic molecules, including protonated molecules. This study also used the 6-31G(d) basis set, a split valence basis set that includes polarization functions. These allow it to accurately model hydrogen bonding, the effects of protonation, and any changes due to solvation while balancing efficiency and accuracy. This study used this B3LYP/631G(d) method across neutral, protonated, solvated, and gas-phase models of dopamine, serotonin, and epinephrine, which provided a consistent baseline for comparison. Solvation effects were modeled using an implicit water solvent model with the Gaussian framework. This ensured that differences in the resulting data reflected true chemical behavior rather than random methodological inconsistencies.

The data collected in this study included the HOMO and LUMO energies, the HOMO - LUMO energy gaps, the total electronic energies, the dipole moments, the polarizability values, and the zero-point correction energy values for each molecule, under each state of protonation and / or solvation. The HOMO and LUMO energies describe how well a molecule can donate or accept electrons, with higher HOMO and lower LUMO values representing a molecule that can undergo these reactions easily. The HOMO - LUMO gap represents the overall stability of the molecule by determining the excitation energy, where a smaller gap indicates greater reactivity because it corresponds to a smaller excitation energy. The total energy describes the overall stability of the molecule, with smaller values indicating a more stable structure. The dipole moment tracks the polarity of a molecule and how the molecule is affected by interacting electronic fields. Polarizability describes how easily the molecule’s electron cloud can be altered or distorted. The zero-point energy correction represents a more accurate descriptor of the molecule’s energy, as it estimates the intrinsic vibrational energy when the molecule is not assumed to be in a fixed geometry. These values were important because they each described a different aspect of the molecule’s behavior. The HOMO and LUMO values, with the HOMO - LUMO gap, gave valuable information about how these neurotransmitters interact with electron donors and acceptors; the dipole moment and polarizability values modeled how these neurotransmitters interact with their environment, especially water; and the total electronic- and zero-point-corrected- energy values gave insight into the stability and reactivity of each neurotransmitter. Together, these descriptors allowed for a deeper understanding of how small molecular changes can significantly shift biological pathways.

However, while these values outlined the overall behavior of each transmitter, it was also important to consider the molecule’s environment. If the molecule was protonated, or placed in a water solvent, the behavior changed. Protonation [@lagutschenkov_infrared_2011] and solvation [@rizo_mechanism_2018] alter the electron density, charge distribution, and structural flexibility of each neurotransmitter. This, in turn, affects the reactions that the molecule may be a part of [@noauthor_mopac_nodate]. When looking at the broader picture, these small changes affect how neurotransmitters behave in the body. Protonation typically simulates the way chemical reactions occur in the body’s slightly acidic to neutral pH, while solvation typically mimics the conditions of aqueous biological environments. Solvation stabilizes the polar functional groups, increases dipole interactions, and often lowers the overall energy of most molecules, reflecting how neurotransmitters behave in extracellular fluid and across synapses. Protonation, on the other hand, usually determines whether a molecule is in a charged or neutral state, which directly influences receptor affinity, transport, and metabolic breakdown. This is one way the central nervous system can regulate the synthesis, storage, and release of certain neurotransmitters.

Despite the integral role of neurotransmitters in nearly all biological functions, many computational and theoretical studies approach neurotransmitters as if they were in a vacuum, assuming simplified protonation or solvation states. Practically, this limits how accurately researchers can connect molecular properties to biological behavior. This work addresses a gap in neurotransmitter research by explicitly modeling these molecular states. Based on the known effects of charge and solvent stabilization on molecular electronic structure, it was hypothesized that protonation would significantly increase dipole moment and decrease orbital energies, while solvation would primarily increase polarizability due to environmental stabilization.

By focusing on three major neurotransmitters, consistently using accurate computational methods, and connecting small intermolecular changes to larger biological effects, this lab aimed to answer the following research question: How do protonation and solvation alter the structural, energetic, and electronic properties of dopamine, serotonin, and epinephrine, and what do these changes reveal about their biological behavior and function in the central nervous system?

## Computational Approach/Method

All molecular calculations were performed using Gaussian [@noauthor_north_nodate; @polik_webmo_2022] on the high school computational chemistry server [@noauthor_wolfram_nodate]. With the exception of serotonin, all structures were optimized and analyzed at the B3LYP/6-31G(d) level of theory [@lo_striking_2025], providing a consistent computational framework for comparing the neutral, protonated, gas-phase, and solvated forms of dopamine, serotonin, and epinephrine.

For the neutral, gas-phase versions of dopamine, serotonin, and epinephrine, each structure was first built and then underwent a full geometry optimization. This was followed by a vibrational frequency calculation to verify that the optimized structure exhibited zero imaginary frequencies. If this calculation reported one or more imaginary frequencies, the geometry was reassessed and re-optimized until a true optimization was obtained. Once a stable geometry was confirmed, a molecular orbitals analysis was performed. The protonated, gas phase versions of these molecules were then constructed by manually adding a hydrogen atom to the terminal nitrogen of the C–C–N chain in dopamine and serotonin, and to the central nitrogen atom of the C–N–C chain in epinephrine. These protonation sites were chosen based on a thorough literature review, which consistently identified the primary amine chains as the optimal site for protonation. Each protonated structure underwent the same sequence of geometry optimization, frequency verification, re-optimization when necessary, and molecular orbitals analysis. This process was repeated for the neutral, solvated molecules, which were built in the presence of an implicit water solvent field and processed using the same method sequence. Finally, the solvated, protonated versions were constructed by adding hydrogen atoms to the appropriate nitrogen atoms present in the side chains. These structures were again optimized, confirmed with a vibrational frequency calculation, re-optimized as needed, and analyzed with a molecular orbital calculation. From each molecular orbital analysis, the following values were collected: the HOMO energy (eV), LUMO energy (eV), Dipole moment (Debye), Total Electronic energy (Hartree), HOMO-LUMO gap value (eV), Zero Point Correction energy (Hartree), and the Polarizability value (Bohr$^3$). Collecting the same set of variables for all molecules and all conditions ensured that any observed differences reflected true chemical effects rather than methodological variation.

@Figure_3 depicts the protonated molecular structures of dopamine, serotonin, and epinephrine, built and manually protonated in the high school computational chemistry server.

``` {figure} images/browning_fig_3.png
:name: Figure_3
:align: center

Protonated Molecular Structures of Dopamine, Serotonin, and Epinephrine
```

@Figure_4 depicts the optimized, protonated, and solvated structures of dopamine, serotonin, and epinephrine, illustrating the geometry and charge distribution used for all protonated starting structures in this study.

``` {figure} images/browning_fig_4.png
:name: Figure_4
:align: center

Combined Protonated and Solvated Molecular Structures
```

In this study, all computational calculations were successfully performed with the B3LYP / 6-31G(d) level of theory except protonated serotonin, both gas phase and when in solvent. The geometry optimizations for these calculations repeatedly failed to produce meaningful results. Despite repeated attempts with various higher-level theories, each vibrational frequency check reported two or more significant imaginary frequencies, indicating that the geometry was not fully optimized. The geometry optimization and vibrational frequency check calculations were finally successful when performed with the PM6 / 6-31G level of theory.

Serotonin’s indole ring, when interacting with protonated structure, can create unrealistic representations of its electronic distribution. While a DFT theory may not be able to stabilize these inconsistencies, a PM based theory is well suited for unstable molecules like this. As it is less strict than DFT, PM6 is able to work with “looser” approximations. However, the molecular orbital calculations remained successful with the B3LYP theory, after this geometry had been confirmed. This allowed for a reliable comparison between all three molecules, despite the early issues with serotonin.

## Results

### General Overview

Once each neurotransmitter was compared across solvated and protonated states, several key patterns were observed. The following section explores the major trends in the data and highlights the structural and molecular reasoning behind each. The results are divided into sections based on the property that was analyzed. All numerical data was obtained from the molecular orbitals analysis on each molecule, and visualized using Wolfram and Mathematica software [@noauthor_wolfram_nodate]. 

### Neutral, gas phase molecules

Establishing a baseline for each molecule was necessary before evaluating protonation and solvation effects. In order to appropriately analyze the solvated or protonated versions, the patterns present in the neutral or gas phase versions of each molecule needed to be determined first.

For the neutral, gas phase version of dopamine, the values were as follows: the HOMO energy was -5.489352898 eV, the LUMO energy was 0.2323852364 eV, the Dipole moment was 3.5125 Debye, the total electronic energy was -516.652644269 Hartree, the HOMO - LUMO gap was 5.721738134 eV, the Zero Point Correction energy was 0.183087 Hartree, and the Polarizability value was 95.26 Bohr$^3$.

The dipole moment here was moderately high, the HOMO–LUMO gap was mid-range compared to the set, and the polarizability was on the lower end relative to the other two molecules.

For the neutral gas phase version of serotonin, the values were as follows: the HOMO energy was -5.132611627 eV, the LUMO energy was -0.0617698462 eV, the Dipole moment was 3.0820 Debye, the total electronic energy was -573.001402981 Hartree, the HOMO - LUMO gap was 5.070841781 eV, the Zero Point Correction energy was 0.208032 Hartree, and the Polarizability value was 118.33 Bohr$^3$. The HOMO here was the highest of the three neutral molecules, the dipole moment was moderate, the HOMO–LUMO gap was the smallest of the group, and the polarizability was the highest.

For the neutral, gas phase version of epinephrine, the values were as follows: the HOMO energy was -5.908408242 eV, the LUMO energy was 1.302881162 eV, the Dipole moment was 2.7163 Debye, the total electronic energy was -634.765595399 Hartree, the HOMO - LUMO gap was 7.211289404 eV, the Zero Point Correction energy was 0.286086 Hartree, and the Polarizability value was 110.02 Bohr$^3$. This molecule showed the lowest dipole moment of the three, the highest HOMO–LUMO gap, and a polarizability value that was high but not the highest.

### Protonated, gas phase molecules

Comparing the molecules in which only the protonation state changed provided a second baseline for comparison before analyzing solvation effects.

For the protonated, gas phase version of dopamine, the values were as follows: the HOMO energy was -8.520429184 eV, the LUMO energy was -4.460218279 eV, the Dipole moment was 17.0660 Debye, the total electronic energy was -517.023953301 Hartree, the HOMO - LUMO gap was 4.060210905 eV, the Zero Point Correction energy was 0.197970 Hartree, and the Polarizability value was 96.24 Bohr$^3$. This molecule showed the highest dipole moment of the three protonated molecules, a mid-range HOMO–LUMO gap, and a polarizability on the lower end compared to the group.

For the protonated, gas phase version of serotonin, the values were as follows: the HOMO energy was -7.895655762 eV, the LUMO energy was -4.487157551 eV, the Dipole moment was 16.2920 Debye, the total electronic energy was -573.370397603 Hartree, the HOMO - LUMO gap was 3.408498211 eV, the Zero Point Correction energy was 0.221864 Hartree, and the Polarizability value was 119.83 Bohr$^3$. Here the HOMO was the highest (least negative) among the protonated molecules, the dipole moment was moderate, the HOMO–LUMO gap is the smallest of the group, and the polarizability was the highest.

For the protonated, gas phase version of epinephrine, the values were as follows: the HOMO energy was -9.424663541 eV, the LUMO energy was -3.53748018 eV, the Dipole moment was 14.2251 Debye, the total electronic energy was -635.167314174 Hartree, the HOMO - LUMO gap was 5.887183361 eV, the Zero Point Correction energy was 0.302258 Hartree, and the Polarizability value was 108.68 Bohr$^3$. This molecule showed the lowest dipole moment of the protonated set, the largest HOMO–LUMO gap, and a polarizability that fell between the other two.

### Neutral, solvated molecules

Then, comparing the molecules with only the solvation state changed, provided a second baseline for comparison before analyzing the effects of both solvation and protonation.

For the neutral, solvated version of dopamine, the values were as follows: the HOMO energy was -5.63330113 eV, the LUMO energy was 0.1014984698 eV, the Dipole moment was 4.5968 Debye, the total electronic energy was -516.664661708 Hartree, the HOMO - LUMO gap was 5.7347996 eV, the Zero Point Correction energy was 0.182797 Hartree, and the Polarizability value was 122.53 Bohr$^3$. Dopamine showed a moderate dipole moment and a polarizability that had increased noticeably from its gas-phase value. Its HOMO–LUMO gap remained mid-range compared to the other neutral, solvated molecules.

For the neutral, solvated version of serotonin, the values were as follows: the HOMO energy was -5.30268279 eV, the LUMO energy was -0.2544264591 eV, the Dipole moment was 4.0466 Debye, the total electronic energy was -573.015896351 Hartree, the HOMO - LUMO gap was 5.048256331 eV, the Zero Point Correction energy was 0.208098 Hartree, and the Polarizability value was 155.77 Bohr$^3$. Serotonin showed a slightly lower dipole moment than dopamine but the highest polarizability of the neutral, solvated set, along with the smallest HOMO–LUMO gap.

For the neutral, solvated version of epinephrine, the values were as follows: the HOMO energy was -5.900244826 eV, the LUMO energy was 1.842210832 eV, the Dipole moment was 1.7544 Debye, the total electronic energy was -634.783876924 Hartree, the HOMO - LUMO gap was 7.742455658 eV, the Zero Point Correction energy was 0.286339 Hartree, and the Polarizability value was 138.92 Bohr$^3$. Epinephrine had by far the lowest dipole moment in solvent, along with the largest HOMO–LUMO gap; its polarizability fell between that of dopamine and serotonin.

### Protonated, solvated molecules

Finally, using the basis set up in the first data set, the solvated and protonated molecules were appropriately compared to the neutral, gas phase molecules.

For the protonated, solvated version of dopamine, the values were as follows: the HOMO energy was -5.849359535 eV, the LUMO energy was -0.1140157073 eV, the Dipole moment was 20.7395 Debye, the total electronic energy was -517.125508934 Hartree, the HOMO - LUMO gap was 5.735343828 eV, the Zero Point Correction energy was 0.198864 Hartree, and the Polarizability value was 120.08 Bohr$^3$. This showed a very high dipole moment, noticeably higher than its neutral, solvated counterpart, with a mid-range HOMO–LUMO gap and a moderate polarizability.

For the protonated, solvated version of serotonin, the values were as follows: the HOMO energy was -5.507040299 eV, the LUMO energy was -0.4427292502 eV, the Dipole moment was 19.5730 Debye, the total electronic energy was -573.471255954 Hartree, the HOMO - LUMO gap was 5.064311049 eV, the Zero Point Correction energy was 0.222424 Hartree, and the Polarizability value was 156.37 Bohr$^3$. This displayed a slightly lower dipole moment than protonated dopamine but had the highest polarizability of the group, along with the smallest HOMO–LUMO gap.

For the protonated, solvated version of epinephrine, the values were as follows: the HOMO energy was -7.114688984 eV, the LUMO energy was 0.8653220748 eV, the Dipole moment was 17.6161 Debye, the total electronic energy was -635.257173268 Hartree, the HOMO - LUMO gap was 7.980011059 eV, the Zero Point Correction energy was 0.302650 Hartree, and the Polarizability value was 135.41 Bohr$^3$. This had the lowest dipole moment among the protonated, solvated molecules and the largest HOMO–LUMO gap, while its polarizability remained in a mid-range position between dopamine and serotonin.

## Discussion

### Dipole Moment Changes Upon Protonation

Protonation significantly increased the dipole moment for each neurotransmitter. For example, neutral dopamine had a dipole moment of 3.5 Debye. Then, when protonated, this jumped to 17 Debye, an approximate 385% increase. Both serotonin and epinephrine had similar patterns in their dipole moments– each showing an approximate 425% increase. Overall, these trends suggest that protonation and solvation increase charge separation, making the molecules drastically more polar. This is because adding a positive charge likely shifted the density of the electron cloud, focusing the electrons on one side of the molecule or the other and amplifying the polarity of it. Consequently, the protonated forms of these molecules were more sensitive to interacting electronic fields, including a solvent environment.

In water solvent, these values were generally similar to the gas phase values, with the exception of epinephrine, which saw an approximate 877% increase. This difference likely arises from structural variations among the molecules. Epinephrine’s functional group is physically farther away from its central ring compared to the same distances in dopamine and epinephrine. This means that when protonated, the electron density becomes even more unbalanced, and the physical distance measured in the dipole moment may be somewhat exaggerated. However, the more significant trend when looking at solvation is the increase in polarizability. Here, each molecule saw around a 30% increase in polarizability in water solvent, which supports the idea that solvation, like protonation, alters the electron cloud. All in all, the changes caused by solvation and protonation demonstrated that the dipole moment is an extremely sensitive indicator of environmental effects on molecules. This provided the foundation for analysis of the orbital energies and other variables.

@Figure_5 shows the increase in dipole moment from the molecules’ regular states to their protonated states when in gas phase. The left column represents the neutral state, and the right column represents the protonated state.

``` {figure} images/browning_fig_5.png
:name: Figure_5
:align: center

Dipole Moment by Protonation State
```

Whereas protonation increased the dipole moment, it lowered both the HOMO and LUMO energies, as well as the HOMO - LUMO gap. For each neurotransmitter, the HOMO energies decreased by 2-3 eV, while the LUMO energies decreased by 3-4 eV. This narrowed the distance between these orbitals, meaning it also decreased the energy separation between them. This would indicate that polarization makes the molecules more stable. Similarly, the total electronic energies were lowered upon protonation and solvation in each molecule, supporting this indication. Although the simultaneous increase in dipole moment and decrease in total electronic energy may seem contradictory, both effects were actually true.

What made this contradiction interesting became clear when looking at the real-world reactivity of neurotransmitters. The reactivity of these molecules in biological systems does not depend primarily on orbital overlap, but rather on electrostatic interactions such as hydrogen bond formation, protonation, and receptor binding specificity, all of which occur when the neurotransmitter reacts to its environment. Therefore, the dipole moment is likely a more relevant descriptor of reactivity than the HOMO - LUMO gap or the total electronic energy.

@Figure_6 depicts the changes in HOMO - LUMO gap values upon protonation, for both the neutral and protonated forms of dopamine, serotonin, and epinephrine. For each set of four columns the designations are: The first two, lighter, columns represent the neutral molecule in gas phase and water solvent, respectively. The second two, darker, columns represent the protonated molecule in gas phase and water solvent, respectively.

``` {figure} images/browning_fig_6.png
:name: Figure_6
:align: center

HOMO - LUMO Gap Across Protonation and Solvation States
```

### PCA Analysis

A Principal Component Analysis (PCA) was performed to summarize multiple variables into computed ‘principal components.’ This was able to depict many of the significant variations present in the data. PCA analysis of each molecules’ measured properties confirmed that each molecule fell into a unique electronic “zone,” even before protonation. This reflects the unique structural and electronic profiles of different neurotransmitters. Once protonated, each molecule shifted in the same general direction, although the magnitude of the shift varied in each. This means that when analyzing multiple variables, meaningful trends were still present. Most importantly, this analysis revealed relationships not obvious from single-variable comparisons, yet supported by them. This provided confidence to the observations above, and indicates that previous findings were not caused by methodological error.

@Figure_7 shows the PCA analysis of each molecule, in both neutral and protonated forms. Variables considered in the analysis were the HOMO energy, LUMO energy, HOMO - LUMO Gap, Dipole Moment, and Polarizability values. A circle represents the molecule in its neutral state, and the square represents the molecule in its protonated state.

``` {figure} images/browning_fig_7.png
:name: Figure_7
:align: center

PCA Visualization
```

### Correlation Matrix Analysis

After the PCA, a correlation matrix was created to more accurately understand the relationships between variables. Two key observations were noted. First, the dipole moment showed a strong negative correlation with the HOMO and LUMO energies, the HOMO–LUMO gap, and the total electronic energy. This suggests that increases in charge separation were consistently associated with decreases in electronic energy levels. Second, the HOMO–LUMO gap showed a weak correlation with nearly every other variable, reinforcing the idea that the orbital gap may not be the primary determinant of neurotransmitter reactivity. Third, polarizability exhibited only weak correlations with the other variables. This suggests that polarizability changes arise mainly from geometric or structural alterations rather than direct electronic stabilization or destabilization.

This reflects real world neurotransmitter patterns. The brain is able to regulate neurotransmitter interactions by modifying the protonation state or environment of each molecule. This physically affects the molecular shape, therefore determining which receptors or proteins it can physically interact with. This new trend introduced the idea that protonation is independent of other variables, indicating it creates a primarily physical effect instead of an electrostatic one.

@Figure_8 compares each variable, measuring the correlation between them. The color gradient indicates the strength of correlation, with a lighter color trending towards a strong negative correlation.

``` {figure} images/browning_fig_8.png
:name: Figure_8
:align: center

Correlation Matrix Visualization
```

### Three-Dimensional Structural and Electronic Shifts

After the correlation matrix was created, two 3D graphs were created to visualize the physical properties of each molecule in multi-dimensional space. This revealed an important insight. Even though protonation caused structural differences, as discussed above, the direction of the shift was consistent between dopamine, serotonin, and epinephrine. As seen in the first 3D figure, based on their original locations with dopamine sitting at the lower values, serotonin sitting at mid range values, and epinephrine sitting at the higher values, it was concluded that polarizability may be an appropriate descriptor not just of the molecules’ behavior, but molecules’ structural identity. Even once protonated or placed in water solvent, polarizability separated molecule identity. Additionally, dipole moment was the most appropriate descriptor of protonation status. As the second 3D figure, serotonin exhibited the largest protonation-induced shifts, dopamine moderate shifts, and epinephrine the smallest shifts. When in water solvent, these changes weakened overall. Importantly, the dipole moment contributed the most to each shift. This demonstrated that dipole moment, the property most sensitive to protonation, is the most relevant descriptor. to modeling real - world neurotransmitter interactions.

@Figure_9 shows where each molecule sits in three dimensional space, with regards to polarizability, dipole moment, and energy. Points are included for solvated and gas phase versions of each neurotransmitter. The labels on each point designate the molecule and phase it is measured in. The color gradient indicates the measured dipole moment, from lower to higher values.

``` {figure} images/browning_fig_9.png
:name: Figure_9
:align: center

Three Dimensional Neurotransmitter Visualization
```

@Figure_10 shows the physical shift in three dimensional space, with regards to dipole moment and HOMO / LUMO values. Arrows represent the shift in these values from the molecule’s neutral state to its protonated state. A larger arrow indicates a stronger effect, and a smaller arrow indicates a weaker effect.

``` {figure} images/browning_fig_10.png
:name: Figure_10
:align: center

Visualization of Shifts from Neutral to Protonated States
```

These computational results suggest that subtle molecular changes, such as protonation and shifts in dipole moment or polarizability, could have meaningful effects on neurotransmitter behavior in real biological environments.

Neurotransmitters function in an electrically ever-changing, slightly basic pH environment. This essentially means that they may rely on the smallest electrostatic interactions to interact with their surroundings.

If protonated, they are more easily able to bind to receptor sites. As an area in their molecular structure gains a slight charge, it becomes attracted to the opposite charge on the binding site. Because all three of these neurotransmitters must rely on an active transporter to pass through the blood brain barrier, protonation ensures they can adequately bind to those transporters. Overall, protonation improves receptor interaction and helps regulate where neurotransmitters “exist” within the body.

When protonated, the dipole moment increases. As the molecule becomes more polar, it can more easily dissolve in extracellular fluid, improving diffusion into the nerve synapse. Additionally, as the molecule increases in polarizability and its electron cloud distribution becomes more easily distorted, this also improves binding capabilities, as well as binding strength. This may determine how long the receptor stays activated, or how strong the effects of this receptor will become. This may regulate processes such as motor or mood control within the brain.

With all of these changes, it is important that the molecule remains stable. Lower HOMO and LUMO energies allow the molecule to remain intact throughout the entire process, while still allowing it to be degraded when appropriate. Regulating the levels of certain neurotransmitters may help the brain prevent neurological disease. Overall, molecular changes have significant biological impacts.

Taken together, these molecular insights illustrate how changes in electronic structure and protonation state may directly influence receptor interactions and neural function, bridging the gap between computational predictions and real-world neurotransmitter activity.

### Interpretation

Together, these trends provided a complete view of dopamine, serotonin, and epinephrine. Their unique responses to protonation and solvation were seen in the changes in dipole moment, orbital energies, and polarizability. While some theoretical trends initially seemed in conflict with one another, realistic patterns soon emerged when considering the bigger picture of neurotransmitter behavior in biological systems. The dramatic increase in dipole moment upon protonation likely affects how each neurotransmitter orients itself in the polar extracellular fluid. This means that neurotransmitters with larger dipole moments will be very sensitive to surrounding electronic fields. This determines how easily they would be attracted to or repelled from receptor sites. The effects of solvation support these conclusions. The biological functions of each neurotransmitter depends heavily on hydrogen bond formation. For example, dopamine had a strong tendency to form hydrogen bonds. This explains its shorter diffusion ability, compared to the others.

These results show how the function of each neurotransmitter may be determined long before it actually reaches its biological end-point. Each molecular change influences how neurotransmitters move across synapses and bind to receptors, and therefore determines what outcome this will create.

## Conclusion

In conclusion, the findings demonstrated that protonation significantly altered the electron density distribution. In the brain, this reflects how neurotransmitters bind to receptors. These neurotransmitters are biologically protonated in a slightly acidic pH environment to appropriately bind to their receptors. Specifically, the positive charge contributed by the extra proton creates an electrostatic “bridge” to the receptor. This explains why protonation makes the molecules so sensitive to their environment. It must be– otherwise the neurotransmitter literally would not function.

Solvation, which appeared to make the neurotransmitters more stable, did not necessarily contribute to the orbital - based findings. However, the hydrogen bonding that occurs in extracellular fluid explains why neurotransmitters are only allowed to diffuse very short distances across synapses. The brain tightly regulates these neurotransmitters. Lastly, protonation and solvation modeled how the dipole moment is the primary determinant of neurotransmitter behavior. This change in polarity explains one of the most important aspects of neurotransmitter behavior– the permeability across the blood brain barrier, which depends on the charge and polarity of the molecule.

While these findings do reveal clear trends, a few limitations should be acknowledged when interpret- ing these results. All calculations relied on a primary level of theory, B3LYP/6-31G(d). This method is widely used for organic molecules and represents an approximation of true molecular behavior. However, serotonin required geometry optimization with a semi-empirical PM6 method due to persistent imaginary frequencies, introducing a minor methodological inconsistency across the dataset. Additionally, while these results are intended to model biological environments, they cannot perfectly represent the complex and dynamically changing conditions of a neural environment.

Overall, these results model how small molecular interactions contribute to large-scale biological effects. While protonation and solvation alter electron density at the molecular level, this determines whether a signal is sent or received at the physiological level. These findings may contribute to the future development of treatments for neurological diseases. Specific molecular tailoring could improve how these types of drugs are utilized in the brain, or how neurotransmitter synthesis could be turned on or off as needed. The application of this study to medicine could open new doors in neurological treatment.

From brain chemistry to computational chemistry, this study shows that even the most important biological functions are determined by the smallest intermolecular changes.
## Acknowledgements

Appreciation to the Burroughs Welcome Fund (http://bwfund.org) and the North Carolina Science, Mathematics, and Technology Center (http://ncsmt.org, RTP) for their funding support for the North Carolina High School Computational Chemistry Server. Appreciation is also expressed to the NCSSM Department of Science; Dr. Amy Sheck, Dean; and special thanks to Mr. Gotwals, instructor.
