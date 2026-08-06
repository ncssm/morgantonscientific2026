---
title: Generalization Failures in AI-Based Leukemia Detection
abstract: |
  Artificial Intelligence models for detecting leukemia from blood smear images have reported impressive classification accuracies, with many being above 97%. However, as the field of AI-assisted healthcare grows, a growing body of evidence reveals that these figures are very localized and accuracy often drops outside of the specific lab conditions in which the models were trained. This review examines how differences in slide preparation, staining protocols, hardware, and imaging software cause AI model performance to deteriorate when tested at new institutions. This paper also surveys datasets commonly used in this field and critiques the single-centered evaluation culture that dominates the literature in this field. Findings indicate that cross-institution accuracy drops multiple percentages and that stain normalization is underused. 
---

## Introduction

Leukemia is a cancer of the white blood cells in which abnormal cells outnumber healthy ones in the bloodstream. The two types relevant to this paper are acute lymphoblastic leukemia (ALL) and acute myeloid leukemia (AML), both of which require rapid and accurate diagnosis [@noauthor_what_nodate]. For decades, trained hematologists studied blood smears under microscopes and classified cells based on shape, size, and staining appearance [@fox_developing_2007]. This process has grown to be time-consuming, inconsistent, and inefficient as it is prone to inter-observer variability [@makem_reliable_2025].

Machine learning and deep learning models, particularly convolutional neural networks (CNNs) and, more recently, Vision Transformers (ViTs), have been proposed as tools to automate this process [@makem_reliable_2025]. CNNs extract spatial features from images through hierarchical learned filters, while ViTs apply self-attention across image patches to capture long-range dependencies that CNNs may miss. These models analyze thousands of labeled images and learn to distinguish between cancerous blast cells and healthy white blood cells (WBCs). On well-known benchmark datasets like ALL_IDB or C-NMC-2019, these systems achieve near-perfect accuracy [@makem_reliable_2025]. However, the benchmark performance recorded in these tests does not translate reliably to performance in new hospitals or institutions with different staining regimens or on different scanners. This review aims to synthesize the literature on AI-based leukemia detection, identifies the sources of domain shift that undermine cross-institutional generalizability, and critiques the single-centered evaluation culture that inflates reported performance metrics.

## Methodology

This review was conducted through a systematic search of PubMed, Google Scholar, and IEEE Xplore using search terms including "leukemia detection deep learning," "blood smear classification CNN," "stain normalization hematology," and "domain generalization pathology AI." Searches were limited to studies published between 2009 and 2025, with emphasis placed on publications from 2020 onward to reflect the current state of the field. An initial pool of approximately 50–60 papers was screened based on title and abstract relevance. Studies were included if they addressed AI-based classification of white blood cells, discussed dataset construction or evaluation methodology, examined generalization and stain variability as variables, or provided important context to the paper. Studies were excluded if they focused on non-hematological cancers or were not relevant to the paper's subject. 

## Commonly Used Datasets and Limitations

The most widely used benchmarks in AI-based leukemia detection are ALL-IDB, a dataset of 108 whole-slide images from one institution. Another common data set is C-NMC-2019, which has 15,114 images from 118 subjects. Other commonly used resources include the AML-Cytomorphology_LMU dataset, containing 17 white blood cell classes from Ludwig-Maximilians-Universität Munich, and Raabin WBC from two Iranian hospitals [@tande_artificial_2025].

These datasets share a fundamental limitation: they originate from one or at most two institutions and use a single staining method with consistent imaging equipment. As a result, the models trained on these databases are accustomed to certain features of an institution, like the particular blue tone of one lab's Giemsa protocol or the background texture introduced by a specific scanner, compared to the actual cell morphology [@ilyas_efficient_2025]. A recent review by @tande_artificial_2025 confirmed that many published studies rely on the small single-source datasets mentioned above, and this leads to “overfitting and poor generalization to real-world data.” 

There are also exceptions to this trend, such as DinoBloom, which is trained on over 380,000 WBC images from 13 different datasets.  Its multi-source training represents the direction the field needs to go toward, but has not taken yet [@linguraru_dinobloom:_2024].

```{figure} images/figure1.jpg
:name: Figure_1
:align: center

Scans of the same histological slide across different scanners produce markedly different color distributions, illustrating the inter-scanner variability that undermines cross-institutional model generalizability [@xu_stain_2025].
```

## CNN and Transformer Model Performance

The dominant approach in leukemia blood smear classification involves the use CNNs [@achir_advances_2025]. A systematic review by @oybek_kizi_review_2025 analyzed 30 research papers and found that CNNs dominate classification literature and that preprocessing significantly boosts reported performance. However, the review also found that a large proportion of evaluations are performed on an internal split of the same dataset, not different datasets. 

Visually transformed and hybrid CNN-transformer models have more recently been applied to this problem. ResViT, a novel technology created by @tanwar_enhancing_2025, fuses ResNet-50, a 50-layer CNN, with a dual-stream transformer, achieving up to 99% accuracy on leukemia subtype classification. The explainable ViT by @katar_explainable_2023 reaches 99.4% accuracy on a five-class WBC dataset. These figures are impressive, but they have limited application because all evaluations are done using internal datasets. Kumari et al. (2025) conducted a study, evaluating several architectures across four distinct institutional datasets, each with different staining protocols and imaging hardware. After testing these architectures on multiple datasets, even large foundation models lost several percentage accuracy points. This makes clear that scale alone is not enough to solve the generalization problem.
 
## Stain Variability as the Core Challenge

Peripheral blood smears and bone marrow aspirates are prepared with several different types of stains, including Giemsa, May-Grünwald-Giemsa (MGG), and Wright stain [@doddagowda_leishman-giemsa_2017]. Each of these stains differs in its dye composition, pH sensitivity, and timing requirements, producing visible differences [@lin_impact_2025]. Even within one stain type, factors like reagent concentration, slide preparation technique, and scanner calibration introduce additional color variation from lab to lab. A 2025 review confirmed that color variations caused by different staining protocols and preparation mechanisms affect the performance of downstream algorithms [@xu_stain_2025].

```{figure} images/figure2.png
:name: Figure_2
:align: center

Visual comparison of the thirteen datasets incorporated into the DinoBloom foundation model, demonstrating the substantial variation in staining appearance, color profile, and imaging conditions across institutions [@linguraru_dinobloom:_2024].
```

The primary technical response to this problem is stain normalization. Stain normalization involves standardizing the color and intensity of histopathology images, making different slide samples look consistent [@hoque_stain_2024]. There has been an effort in the past to improve image consistency through projects such as Macenko's SVD-based stain vector estimation and Reinhard's color transfer method [@macenko_histology_2009]. @anghel_high-performance_2019 demonstrate significant computational speedups and improved robustness to image artifacts in their stain normalization pipeline. However, these evaluations are limited to a single downstream ML dataset and do not address whether the normalization generalizes to model performance across multiple unseen datasets.

More direct evidence comes from @arshad_stain_2024, who applied Neural Color Transfer to peripheral blood and bone marrow slides and evaluated a YOLOv5 detection model on unseen samples before and after normalization. They reported significant improvements in white blood cell detection following normalization, demonstrating that stain variability constitutes a measurable source of performance degradation when models are applied to new institutions or sample types. Despite this evidence, the systematic review by @oybek_kizi_review_2025 found that most preprocessing pipelines in the leukemia AI literature rely on geometric augmentation and intensity rescaling, indicating that stain normalization is not widely adopted yet.

## Gaps in Current Studies

The most fundamental gap is the near-total absence of cross-institution validation. Almost no published leukemia AI study trains on one dataset and tests on a dataset provided by another institution. The systematic review by Aria et al. (2025) searched across four major academic databases and found that 87% of studies relied exclusively on internal validation, leading the authors to conclude with an explicit call for rigorous external validation to evaluate generalizability.

The second gap can be defined as chronic overfitting. ALL-IDB, one of the most widely cited benchmarks, only has 108 whole-slide images, and several papers have reported perfect accuracy on it. This can be attributed to the limited diversity of the dataset rather than diagnostic capabilities [@altalhi_demystifying_2026]. A meta-analysis by @al-obeidat_artificial_2025 found that the heterogeneity of datasets and evaluation metrics across leukemia AI papers makes cross-study comparisons nearly impossible. 

The third gap is the underuse of domain adaptation techniques and stain normalization techniques. While these methods are effective in histopathology for stained tissue, their application to Romanowsky-stained blood smears is still limited.

These three gaps converge on a fourth: clinical risk. Leukemia requires rapid diagnosis because treatment delays as short as a few days can increase the chance of negative outcomes [@genc_diagnostic_2023]. A model that is known to perform at a 98% accuracy rate with a certain dataset, but drops to 75% at a new hospital, would produce false negatives at a clinically dangerous rate. As of today, few AI tools have been fully implemented in clinical practice because of challenges related to data quality, equity, infrastructure, and robust evaluation [@qi_utilization_2025]. 

## Significance & Future Steps

Leukemia kills roughly 23,500 people each year, and for its most aggressive subtypes, diagnosis is a race against time [@national_leukemia_2020]. Acute promyelocytic leukemia is a hematological emergency where time is of the essence [@noauthor_what_nodate-1], and when an  AI model fails silently at a new hospital because of a staining protocol, it doesn’t affect accuracy; it affects families. For these misdiagnosed patients, limited generalization is the difference between life and death. 

This urgency extends globally. The hospitals most in need of automated leukemia diagnosis are those in lower-resource settings with poor infrastructure. These are also the same settings least represented in training data. A model optimized for one institution's imaging infrastructure may fail catastrophically when deployed in underserved settings where the need for automated diagnosis is greatest.

The path to alleviating these challenges requires action on data, methodology, and validation culture. The field needs to develop a multi-institution blood smear benchmark that allows for unity across the model. Efforts like the Leukemia Attri dataset, which has subsets from multiple imaging domains across many microscopes, show how this technology is achievable [@linguraru_large-scale_2024]. On the methodological side, stain normalization needs to become a standard preprocessing step. The deepest change needed is cultural. @aria_towards_2025 found that 87% of studies use internal validation. Journals and reviewers need to establish stricter regulations for a good AI model. A model validated across many institutions would be more valuable than a model with 99% accuracy in one setting.  Without these foundations, reported benchmark accuracies should not be interpreted as indicators of clinical readiness.

## Conclusion

It is undeniable that AI-based leukemia detection has made genuine progress on curated benchmark datasets, but the evidence reviewed in this paper makes it clear that this progress has not translated into applicable clinical tools. Progress in the field is constrained by a structural dependence on single-institution datasets and insufficient adoption of generalization techniques. Across the literature reviewed, performance degradation across institutions is consistently linked to staining variability and imaging differences, yet stain normalization remains underused and most studies continue to rely on single-centered evaluation practices that obscure the true generalization limits of these systems.
