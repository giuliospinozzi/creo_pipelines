# Drug Plates

<p align="justify"> Drug Plates is an application that allows to analyze the results of experiments with drug plates. In particular, for the analysis on single drugs, it generates plots with the model that best fits results and allows to compare up to four different experiments for the same drug. Instead, for the synergy analysis it analyzes the interaction between two drugs generating a plot that shows if they are synergistic, antagonist or additive for the different concentrations. </p>

## IC50

<p align="justify"> The analysis of single drug experiments requires as input a csv file with one drug per line (the names of the drugs are taken from the names of the rows from the table) and the values of the concentrations repeated in triplicate. Below is an example of input: </p>

| | 0.1 | 0.1 | 0.1 | 1 | 1 | 1 | 10 | 10 | 10 | 50 | 50 | 50 |
:--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--:
**A** | 0.7988 | 0.7579 | 0.6512 | 0.7711 | 0.49 | 0.4886 | 0.816 | 0.8641 | 0.513 | 0.6118 | 0.6477 | 0.6086
**NSC** | 0.7913 | 0.6665 | 0.7488 | 0.6846 | 0.5897 | 0.6238 | 0.5034 | 0.5569 | 0.4184 | 0.4209 | 0.4269 | 0.4382
**DMSO** | 0.9624 | 0.6665 | 0.7327 | 0.679 | 0.64 | 0.5587 | 0.5462 | 0.4762 | 0.52 | 0.2925 | 0.2954 | 0.2978

<p align="justify"> For the calculation of the model and of the IC50 the application uses the R package "drc" (Ritz et al., 2015) and in particular the drm function, which is based on the minimization of negative log likelihood function. On the basis of the model obtained, a plot is generated that reports the observed values of the experiments for each drug, a curve that represents the model trend and a dotted line at the IC50 value level. The plot is shown together with a summary table showing the values on which the model was built. It is possible to compare up to four different experiments for the same drug, comparing for example four different cell lines, provided the number and the names of the drugs are the same, as well as the concentrations at which the experiments were made. In the same plot the results for the different cell lines will be reported in different colors. You can download the plots individually or generate a report with the results for all the drugs analyzed. </p>

<p align="center"><img src="/images/IC50.png" width="100%"></p>

## Drug synergy

<p align="justify"> Synergy analysis requires two csv files as input, one for drug combinations and one for single drugs. In the first file there are 8 repetitions in triplicate in a 24x8 table, while in the second file another 8 triplicate concentrations reported in a 24x2 table with one drug per row. Here are two examples of input (attention to the distribution of triplicates): </p>

| DrugA/DrugB | 0.000001 | 0.0005 | 0.002 | 0.01 | 0.05 | 0.2 | 1 | 5 | 0.000001 | 0.0005 | 0.002 | 0.01 | 0.05 | 0.2 | 1 | 5 | 0.000001 | 0.0005 | 0.002 | 0.01 | 0.05 | 0.2 | 1 | 5 | 
:--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--:
**5** | 1.5558 | 1.0468 | 1.0375 | 1.0335 | 1.2194 | 1.0514 | 1.0066 | 0.5089 | 1.1746 | 0.9448 | 0.9544 | 0.9837 | 1.173 | 0.9798 | 0.9492 | 0.5162 | 1.1093 | 0.9625 | 1.0205 | 0.9454 | 1.2383 | 0.9772 | 1.0219 | 0.5075
**1** | 1.0128 | 1.0042 | 0.9779 | 0.8976 | 0.8589 | 0.8305 | 0.8404 | 0.6649 | 0.7977 | 0.8958 | 0.8094 | 0.9006 | 0.8629 | 0.9245 | 0.8425 | 0.5264 | 0.7885 | 0.7852 | 0.9124 | 0.9668 | 0.9959 | 0.8088 | 0.924 | 0.6698
**0.2** | 1.029 | 0.936 | 0.9007 | 0.9397 | 1.0109 | 0.9531 | 0.8564 | 0.6333 | 0.9343 | 0.9269 | 0.7643 | 0.8274 | 0.8535 | 0.9094 | 0.7605 | 0.5506 | 0.8042 | 0.925 | 0.9079 | 0.9237 | 0.9924 | 0.9707 | 0.9254 | 0.7401
**0.05** | 0.9456 | 0.9769 | 0.8887 | 0.973 | 0.9178 | 0.8769 | 0.8274 | 0.5747 | 0.8471 | 0.8752 | 0.7802 | 0.896 | 0.8131 | 0.8655 | 0.7999 | 0.6119 | 0.9138 | 0.9104 | 0.8978 | 0.9579 | 0.9319 | 0.9734 | 0.9582 | 0.7914
**0.01** | 1.4579 | 0.9893 | 1.0393 | 0.9677 | 1.267 | 1.0108 | 0.8597 | 0.6729 | 1.2 | 0.8255 | 0.7964 | 0.9002 | 1.2037 | 0.8062 | 0.8052 | 0.6409 | 1.2345 | 0.8146 | 0.8298 | 0.7965 | 1.1656 | 0.809 | 0.7691 | 0.6924
**0.002** | 0.9525 | 0.9695 | 1.0001 | 0.9717 | 0.94 | 0.9373 | 0.8835 | 0.7038 | 0.9226 | 0.8981 | 0.7989 | 0.8485 | 0.9228 | 0.8272 | 0.9143 | 0.7243 | 0.8217 | 0.8622 | 0.7797 | 0.8518 | 0.8398 | 0.8504 | 0.8158 | 0.7227
**0.0005** | 1.3814 | 0.9728 | 0.9508 | 1.0592 | 1.1375 | 0.8867 | 0.8592 | 0.6721 | 1.2494 | 0.9756 | 0.868 | 0.803 | 1.2749 | 0.8551 | 0.8736 | 0.6833 | 1.2202 | 0.785 | 0.9162 | 0.896 | 1.2476 | 0.7855 | 0.8201 | 0.7326
**0.00001** | 0.9322 | 1.0068 | 1.0148 | 1.007 | 0.8975 | 0.8729 | 0.8357 | 0.6826 | 0.9563 | 0.955 | 0.7958 | 0.8946 | 0.9573 | 0.9449 | 0.9381 | 0.6902 | 0.8444 | 0.9437 | 0.858 | 0.9256 | 0.8773 | 0.9296 | 0.7841 | 0.7157

| | 10 | 10 | 10 | 2 | 2 | 2 | 0.6 | 0.6 | 0.6 | 0.1 | 0.1 | 0.1 | 0.03 | 0.03 | 0.03 | 0.008 | 0.008 | 0.008 | 0.002 | 0.002 | 0.002 | 0.0005 | 0.0005 | 0.0005 | 
:--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--:
**DrugA** | 0.9065 | 0.871 | 0.8076 | 0.8871 | 0.9251 | 0.9569 | 1.031 | 0.9969 | 0.9501 | 0.9747 | 0.9156 | 0.7875 | 0.9024 | 0.9483 | 0.8881 | 0.9857 | 0.9362 | 0.9522 | 0.8964 | 0.8841 | 0.866 | 0.8483 | 0.9252 | 0.9451
**DrugB** | 0.3842 | 0.2852 | 0.2517 | 0.8469 | 0.8737 | 0.8448 | 0.6464 | 0.7124 | 0.895 | 0.9446 | 0.9082 | 0.9372 | 0.8384 | 0.8345 | 0.7416 | 0.7507 | 0.8316 | 0.9251 | 0.8854 | 0.8132 | 0.827 | 0.7868 | 1.022 | 1.0507

<p align="justify"> For the calculation of the interaction between drugs we have resorted to the DDCV scripts (Tongwu Zhang et al., 2015) that use the median-effect principle (Chou TC et al., 2006). The results show two summary tables with the average of triplicates of the input tables, and two plots. The first is a representation of the isobologram, in which it is reported for each combination of the two drugs whether it is synergy, antagonism or additivity and the strength of the interaction. The second is a heatmap that reports values proportional to the strength of interaction to better orientate itself in the isobologram. The results can be exported to a report. </p>

<p align="center"><img src="/images/Drug_synergy.png" width="100%"></p>

## References

- <p align="justify"> Ritz, C., Baty, F., Streibig, J. C., Gerhard, D. "Dose-Response Analysis Using R." PLOS ONE, 2015 10(12), e0146021 </p>
- <p align="justify"> Tongwu Zhang et al. “Drug-Drug Combination Visualization (DDCV): Evaluation of Drug-Drug Interactions using Shiny by RStudio.” 2015. </p>
- <p align="justify"> Chou, T.C., “Theoretical basis, experimental design, and computerized simulation of synergism and antagonism in drug combination studies.” Pharmacol Rev. 2006 58(3), 621-81. </p>
