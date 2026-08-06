---
title: Comparative Evaluation of Neural Network Compression Techniques Across Cloud GPU, NPU, and CPU Platforms
abstract: |
    Neural network model compression is essential for deploying deep learning models on resource-constrained edge devices, yet most research evaluates compression techniques exclusively on cloud-based GPU infrastructure. This study systematically compares three compression methods: magnitude-based pruning, post-training INT8 quantization, and knowledge distillation. We tested these methods across diverse hardware platforms: cloud GPU (NVIDIA T4), modern laptop NPU (Intel Core Ultra 5), and legacy desktop CPU (Intel Core i5-8400). Using MNIST and CIFAR-10 benchmarks with custom convolutional architectures, we evaluated accuracy preservation, model size reduction, and inference latency across 46 experimental configurations. 
    
    Our results challenge conventional assumptions about inference deployment. The Intel Core Ultra 5 NPU achieved 3× faster baseline inference than the cloud GPU, with this advantage amplifying to 5.5× for quantized models. Surprisingly, the 2017 desktop CPU matched cloud GPU performance for baseline models and achieved 10× speedup for knowledge-distilled student models. We identified 50-70% as the optimal pruning range, with complex tasks showing catastrophic accuracy degradation beyond this threshold. Among compression techniques, INT8 quantization demonstrated superior performance: 3.5× size reduction, maintained or improved accuracy, and largest speedup on NPU hardware (1.87× versus 1.48× on GPU), suggesting architectural optimization for low-precision operations.
    
    These findings indicate that edge deployment with compressed models can achieve superior performance compared to cloud infrastructure, with important implications for privacy-preserving, low-latency, and cost-effective AI system design. Our results suggest a paradigm shift from cloud-centric to edge-centric deployment strategies for neural network inference.
---
 
## Introduction
The deployment of deep neural networks has traditionally assumed cloud-based GPU infrastructure as the optimal computing environment [@chan2023deep]. This paradigm emerged naturally from the training phase, where GPUs demonstrated overwhelming advantages in accelerating the massive matrix operations required for backpropagation [@goodfellow2016deep] [@sze2017efficient]. However, inference (the deployment phase where trained models make predictions on new data) presents fundamentally different computational characteristics and constraints than training. While training requires computing and storing gradients, updating millions of parameters, and processing large batches over many epochs, inference involves a single forward pass with fixed weights, often on individual samples or small batches [@sze2017efficient].

Despite these fundamental differences, the research community has largely evaluated inference performance using the same GPU-centric infrastructure developed for training. This assumption persists even as the application landscape shifts toward edge deployment scenarios demanding real-time inference, strict privacy guarantees, and operation in resource-constrained or disconnected environments [@singh2023edge]. Applications ranging from autonomous vehicles to medical diagnosis increasingly require on-device inference without cloud connectivity, exposing a critical gap between research infrastructure and deployment reality [@wang2025empowering].
### Model Compression Imperative
State-of-the-art neural networks have grown dramatically in size and computational requirements. Modern vision transformers can exceed 300 million parameters [@dosovitskiy2021image], while large language models approach trillion-parameter scales [@kaplan2020scaling]. This growth in model capacity has driven impressive performance gains across computer vision, natural language processing, and other domains [@lecun2015deep]. However, it has simultaneously created a deployment crisis: models that achieve state-of-the-art accuracy often cannot run efficiently on the devices where they are needed.

Model compression has emerged as a critical research area addressing this deployment challenge. Three primary approaches have gained prominence in the literature. Pruning techniques identify and remove redundant or less important network connections, exploiting the observation that trained networks often contain significant parameter redundancy [@han2016deep]. The seminal work on magnitude-based pruning demonstrated that networks could maintain performance even after removing 90% of weights in some cases [@han2016deep]. More recent work on structured pruning and the lottery ticket hypothesis has provided theoretical insights into why pruning succeeds [@frankle2019lottery].

Quantization reduces the numerical precision of weights and activations from 32-bit floating point to lower bit-widths, typically 8-bit integers or even binary representations [@liu2025lowbit]. This approach exploits the observation that neural networks exhibit remarkable robustness to reduced precision, often maintaining accuracy even with aggressive quantization [@hubara2017quantized]. Post-training quantization methods enable compression without retraining, while quantization-aware training incorporates precision constraints during the training process [@jacob2018quantization].

Knowledge distillation trains smaller "student" networks to mimic the behavior of larger "teacher" networks, transferring learned representations to more compact architectures [@hinton2015distilling]. This approach differs fundamentally from pruning and quantization by creating entirely new models rather than compressing existing ones. Distillation has proven particularly effective for creating deployment-optimized models while preserving the knowledge learned by large-scale training [@mansourian2025comprehensive].

Each compression technique offers distinct trade-offs between model size, computational complexity, and accuracy preservation. However, a critical question remains underexplored: how do these compression techniques perform on diverse hardware platforms, particularly emerging AI accelerators designed explicitly for efficient inference?
### Evolving Hardware Landscape
The hardware landscape for neural network inference has undergone significant transformation in recent years. While NVIDIA GPUs remain dominant in research and cloud infrastructure, the past five years have witnessed proliferation of specialized AI accelerators targeting inference workloads. Intel, Apple, Qualcomm, and other manufacturers have integrated dedicated Neural Processing Units (NPUs) into consumer devices [@hong2025performance]. These accelerators employ architectural innovations specifically optimized for inference: dedicated matrix multiplication units, optimized memory hierarchies for repeated weight access, and explicit hardware support for low-precision arithmetic [@sze2017efficient].

Modern laptop processors exemplify this architectural evolution. Intel's Core Ultra series (Meteor Lake and Lunar Lake architecture) integrates CPU, GPU, and NPU components on a single die, enabling heterogeneous computing with intelligent workload distribution [@intel2024lunar]. Apple's M-series chips include dedicated Neural Engine cores optimized for machine learning inference [@apple2022neural]. Qualcomm's Snapdragon platforms incorporate Hexagon NPUs for mobile AI acceleration [@qualcomm2024hexagon]. This proliferation of specialized inference hardware raises fundamental questions about optimal deployment strategies.

Preliminary evidence suggests that specialized inference accelerators may provide advantages beyond traditional GPUs. Studies have demonstrated superior energy efficiency for NPU-based inference compared to GPU alternatives [@hong2025performance]. Mobile devices increasingly perform sophisticated on-device AI tasks previously requiring cloud processing [@alahmari2025survey]. However, systematic evaluation comparing compression techniques across diverse hardware architectures remains limited. The research community's GPU-centric evaluation methodology may not capture performance characteristics relevant to emerging deployment scenarios.

Furthermore, the interaction between compression techniques and hardware architecture remains poorly understood. Do certain compression methods provide amplified benefits on specific processor types? Does quantization, for example, achieve greater speedup on NPUs explicitly designed for low-precision operations compared to GPUs where INT8 support was added to architectures primarily optimized for floating-point computation? These questions have important implications for deployment optimization but lack comprehensive empirical investigation.
### Research Gap and Motivation
Existing model compression research exhibits a critical limitation: evaluation occurs almost exclusively on cloud-based GPU infrastructure. This GPU-centric evaluation paradigm reflects the historical development path, where GPUs dominated neural network training, and inference evaluation naturally followed the same infrastructure. However, this approach creates a dangerous assumption: that techniques optimized for GPU deployment will generalize to other hardware architectures.

This assumption becomes particularly problematic as deployment scenarios diversify. Edge computing applications require on-device inference on CPUs, NPUs, or specialized accelerators [@singh2023edge]. Privacy-sensitive applications demand local processing without cloud transmission. Real-time applications cannot tolerate cloud network latency. Cost-conscious deployments seek to avoid cloud API fees and bandwidth charges. Each scenario suggests different optimal hardware configurations, yet compression research provides little guidance for hardware-specific optimization.
### Research Questions
**Question 1:** How does inference performance compare across diverse hardware platforms representing different deployment scenarios? Specifically, we examine cloud GPU infrastructure, modern NPU-enabled consumer laptops, and legacy desktop CPU platforms to characterize performance across the deployment spectrum from cloud to edge.

**Question 2:** Do compression techniques exhibit platform-dependent performance characteristics? We investigate whether pruning, quantization, and knowledge distillation provide differential benefits on GPU versus NPU versus CPU architectures, and whether hardware-compression interactions suggest platform-specific optimization strategies.

**Question 3:** What practical deployment guidelines emerge from systematic cross-platform evaluation? Based on empirical results, we aim to provide actionable recommendations for practitioners selecting compression methods and deployment platforms based on application constraints and available hardware.

## Methods
### Hardware and Software
All experiments in this research study were implemented and carried out in Python (version 3.14.3) using the PyTorch deep learning framework (version 2.10.0). Computations were carried out across multiple hardware platforms using Jupyter to evaluate cross-device performance and ensure reproducibility. Specifically, experiments were run on these three environments.
- Google Colab with an NVIDIA T4 GPU, providing high-performance GPU-accelerated training.
- HP Omnibook X Laptop with an Intel Core Ultra 5 226V CPU, 16 GB RAM, integrated neural processing unit, and Intel ARC integrated graphics. This laptop was used to evaluate CPU-based inference performance and memory efficiency with modern mobile units.
- Lenovo ThinkCentre M720s SFF Desktop, equipped with an Intel Core i5-8400 CPU and 8 GB of RAM. This desktop was used to benchmark desktop, small-form factor CPU-based inference for lower-end computing environments.

### Datasets
All datasets were accessed using the torchvision.datasets module. Preprocessing including converting images to PyTorch tensors and normalizing them using dataset-specific mean and standard deviation values:
- MNIST: Mean = 0.1307, Standard Deviation = 0.3081
- CIFAR-10: Means = [0.4919, 0.4822, 0.4465], Standard Deviations = [0.2023, 0.1994, 0.2010]

Training and testing datasets were loaded into PyTorch DataLoader objects with a batch size of 128, with shuffling enabled for the training sets. These loaders ensured efficient mini-batch processing and randomization during model training, which thereby reduced potential biases and improved convergence.
### Baseline Models
 
```{figure} images/fig1.png
:name: fig1
:align: center
Baseline model architectures. (A) SimpleMNIST: 421,642 parameters, 1.61 MB. (B) SimpleCIFAR: 2,473,610 parameters, 9.44 MB. Both models follow standard CNN architectures with convolutional blocks, pooling layers, and fully connected classifiers.
```


Baseline convolutional neural networks (CNNs) were implemented to provide a starting point for all compression experiments (@fig1). For MNIST, the network – SimpleMNIST – consisted of two convolutional layers followed by two fully connected layers. For CIFAR-10, a deeper network – SimpleCIFAR – containing three convolutional layers and two fully connected layers was employed to accommodate the increased complexity of color image classification.

All convolutional layers utilized ReLU activation functions and max-pooling operations to introduce non-linearity and downsample feature maps. Fully connected layers used standard linear transformations to map extracted features to class probabilities. Both networks were trained using the cross-entropy loss function optimized with the Adam optimizer, with initial learning rates of 0.001. Training continued until the validation accuracy plateaued, and all baseline weights were saved for use as teacher models in knowledge distillation and starting points for pruning and quantization.

The baseline models were deployed on all three computing environments to record reference performance metrics, including test accuracy, model size, and per-image inference latency. These metrics served as control data for comparison with compressed models.

### Compression Techniques
```{figure} images/fig2.png
:name: fig2
:align: center
Neural network compression methods pipeline. Three independent compression approaches were applied to baseline FP32 models: magnitude-based pruning, post-training INT8 quantization, and knowledge distillation. Each method offers distinct trade-offs between model size, computational efficiency, and accuracy preservation.
```

Three primary compression strategies were employed: pruning, quantization, and knowledge distillation (@fig2). Each method targeted a distinct aspect of network optimization—weight reduction, precision reduction, and model simplification—allowing comprehensive assessment of the trade-offs between efficiency and predictive performance.

#### Pruning

Pruning is a technique used to remove redundant or unimportant weights from a neural network. In this study, magnitude-based global unstructured pruning was applied to all convolutional and fully connected layers using PyTorch's `torch.nn.utils.prune` module. Weights with the smallest absolute magnitudes were pruned across the entire network. This approach prioritizes eliminating parameters that contribute minimally to the final output while preserving critical network pathways.

Pruning levels of 30%, 50%, 70%, and 90% were tested to evaluate the effects of increasing sparsity on model performance. Sparsity was quantified as the proportion of zero-valued parameters relative to total parameters in the network. After pruning, models were left un-fine-tuned to isolate the direct structural effects of weight removal. In separate experiments, optional fine-tuning could be applied to restore performance, but the primary focus was to evaluate raw pruning impact.

The rationale for unstructured pruning lies in its ability to reduce model size when stored in sparse formats and decrease computational overhead during inference, particularly in scenarios where sparse matrix operations are supported. This method also provides insights into parameter redundancy in CNN architectures.

#### Quantization

Quantization reduces the numerical precision of model parameters and activations, allowing for more efficient storage and faster inference, especially on CPU-based devices. In this study, post-training dynamic quantization was applied to baseline models. Convolutional and linear layers were converted from 32-bit floating point (FP32) to 8-bit integer (INT8) representations using PyTorch's `quantize_dynamic` method. Dynamic quantization is particularly suitable for deployment scenarios because it requires no additional retraining and automatically selects optimal backend implementations for CPU execution.

The impact of quantization was assessed by measuring model size reductions, inference latency improvements, and accuracy changes on test sets. Model size was estimated by serializing the state dictionary to an in-memory buffer and calculating memory consumption in megabytes (MB). Inference latency was measured as the average time to process a single image, excluding initial warm-up batches to avoid skewed times. MNIST and CIFAR-10 were both evaluated separately to account for differences in input dimensions, overall model size, network depth, and computational complexity.

Quantization was performed on CPU-only backends across all three platforms, enabling comparison of compression benefits in both high-end (NVIDIA T4) and low-end (Intel Core i5) hardware environments.

#### Knowledge Distillation

```{figure} images/fig3.png
:name: fig3
:align: center
Knowledge distillation architecture comparison for MNIST.__ Student model (right) uses 50% reduced channel dimensions compared to teacher (left), resulting in 4× parameter reduction (421,642 → 105,866) and 4× size reduction (1.61 MB → 0.40 MB) while maintaining 99.08% accuracy.
```


Knowledge distillation is a model compression technique in which a smaller "student" network is trained to mimic the output of a larger, pre-trained "teacher" network. This approach transfers knowledge from complex models to lightweight architectures while retaining predictive performance. In this study, student networks for MNIST (TinyMNIST) and CIFAR-10 (TinyCIFAR) were constructed with reduced convolutional channels, fewer neurons in fully connected layers, and dropout layers to improve generalization.

Training of student networks minimized a composite loss function combining the Kullback-Leibler divergence between the softened output distributions of teacher and student models and the standard cross-entropy loss with true labels, with a weighting factor of α = 7 favoring distillation. A temperature parameter of T = 3.0 was applied to soften teacher logits, providing more meaningful information about inter-class relationships than hard labels alone.

Student networks were trained for ten epochs using the Adam optimizer (learning rate of 0.001). Training was conducted on GPU hardware when available to expedite convergence but could be replicated on CPU platforms to validate mobile solutions. During training, teacher models remained in evaluation mode to prevent gradient updates, ensuring that knowledge transfer occurred exclusively through output supervision.

### Evaluation Metrics

Models were evaluated using three primary metrics:

- **Classification Accuracy (%):** the proportion of correctly predicted test examples relative to total test samples.
- **Model Size (MB):** estimated memory footprint obtained by in-memory serialization of model state dictionaries.
- **Inference Latency (ms/image):** measured as the average per-image processing time, excluding warm-up iterations.

Additional secondary analyses included the computation of sparsity percentages for pruned models and compression ratios comparing the number of parameters in student networks to their respective teacher models.

Evaluation was performed on all three platforms to account for differences in CPU architectures, RAM capacities, and GPU availability. The multi-platform assessment provides insights into both computational efficiency and deployment feasibility in varying real-world environments.

### Reproducibility and Transparency

All datasets used in this study are publicly available and were accessed directly through the `torchvision` library. Experiment scripts, including preprocessing, training, compression, evaluation, and plotting routines, were maintained in Jupyter notebooks carefully labelled to ensure clarity and reproducibility. Baseline, pruned, quantized, and distilled models were archived along with the evaluation metrics in CSV files. Figures, tables, and statistical summaries were generated programmatically using `matplotlib` to minimize transcription errors.

### Summary

In summary, the experimental workflow consisted of:

- Loading and processing MNIST and CIFAR-10 datasets.
- Training baseline convolutional networks to convergence.
- Applying pruning at multiple sparsity levels and evaluating structural impact.
- Performing post-training dynamic quantization and evaluating storage, latency, and accuracy.
- Training reduced student networks via knowledge distillation with softened teacher outputs.
- Measuring model performance by testing on multiple hardware platforms.
- Archiving all models, evaluation results, and scripts for easy reproduction.

The framework enabled a comprehensive assessment of neural network compression techniques, providing insights into the trade-offs between model size, computational efficiency, and predictive accuracy.

---

## Results

### 3.1 Baseline Model Performance

```{figure} images/fig4.png
:name: fig4
:align: center
Baseline inference latency comparison across hardware platforms. Intel Core Ultra 5 achieved 3.5× (MNIST) and 3.0× (CIFAR-10) speedup compared to Google Colab NVIDIA T4 GPU. Legacy desktop CPU (i5-8400) matched or exceeded cloud GPU performance.
```

```{table}
:name: Table_1
:align: center
| **Dataset** | **Platform** | **Accuracy (%)** | **Size (MB)** | **Latency (ms)** |
|---|---|---|---|---|
| MNIST | Google Colab (T4 GPU) | 99.12 | 1.61 | 0.565 |
| MNIST | Intel Core Ultra 5 226V | 99.34 | 1.61 | **0.160** |
| MNIST | Desktop Intel Core i5-8400 | 99.44 | 1.61 | 0.202 |
| CIFAR-10 | Google Colab (T4 GPU) | 78.16 | 9.44 | 2.733 |
| CIFAR-10 | Intel Core Ultra 5 226V | 78.37 | 9.44 | **0.923** |
| CIFAR-10 | Desktop Intel Core i5-8400 | 77.68 | 9.44 | 0.900 |

Baseline model performance across hardware platforms. Test accuracy remained highly consistent (MNIST: 99.12–99.44%, CIFAR-10: 77.68–78.37%), confirming that platform-specific optimizations do not affect model quality. However, inference latency varied substantially, with Intel Core Ultra 5 achieving 3.5× and 3.0× speedup compared to Google Colab NVIDIA T4 GPU for MNIST and CIFAR-10, respectively. The Lenovo i5-8400 desktop CPU, a 2017 processor predating the 2018 T4 GPU, matched or exceeded cloud GPU performance. Model size remained constant at 1.61 MB (MNIST) and 9.44 MB (CIFAR-10) across platforms as expected for identical FP32 models. Bold values indicate fastest latency for each dataset.
```

Baseline models were trained for 10 epochs on all three hardware platforms to establish reference performance metrics. Training converged successfully across all platforms, achieving final training accuracies of 99.27% for MNIST and 92.63% for CIFAR-10 on the NVIDIA T4 environment.

Test accuracy remained highly consistent across platforms. For MNIST, accuracy ranged from 99.12% to 99.44% (0.32 percentage point variation). For CIFAR-10, accuracy ranged from 77.68% to 78.37% (0.69 percentage point variation). These small differences prove that platform-specific optimizations did not meaningfully affect model accuracy.

Inference latency measurements revealed substantial platform differences (@fig4). The Intel Core Ultra 5 achieved the fastest inference: 0.160 ms/image for MNIST and 0.923 ms/image for CIFAR-10. This represented 3.5× and 3.0× speedup compared to the Google Colab NVIDIA T4 GPU (0.565 ms and 2.733 ms, respectively). The Lenovo ThinkCentre i5-8400 demonstrated comparable performance to the cloud GPU, achieving 0.202 ms and 0.900 ms for MNIST and CIFAR-10, representing 2.8× and 3.0× speedup over Colab. Model size remained constant at 1.61 MB (MNIST) and 9.44 MB (CIFAR-10) across all platforms.

### 3.2 Magnitude-Based Pruning Results
```{figure} images/fig5.png
:name: fig5
:align: center
Accuracy versus pruning level reveals task-dependent tolerance. MNIST maintained accuracy through 70% sparsity (green safe zone), while CIFAR-10 experienced catastrophic degradation at 90% pruning (19.2 percentage point drop).
```


Unstructured L1 magnitude-based pruning was applied at four sparsity levels (30%, 50%, 70%, 90%) without post-pruning fine-tuning. MNIST models exhibited notable robustness, maintaining 99.34% accuracy through 70% sparsity—representing zero degradation from baseline. At 90% sparsity, accuracy decreased modestly to 98.55%, only a 0.57 percentage point drop.

CIFAR-10 models showed markedly different behavior (@fig5). Accuracy remained stable through 70% sparsity (78.03%, a 0.13 percentage point decrease). However, at 90% sparsity, accuracy exhibited catastrophic degradation to 58.95%—a 19.21 percentage point drop that reduced the model to near-random performance.

Pruned models showed modest latency improvements. On Intel Core Ultra 5, CIFAR-10 latency improved from 0.923 ms (baseline) to 0.836 ms (70% pruned). The Lenovo ThinkCentre showed larger gains: 0.900 ms to 0.665 ms (70% pruned), a 1.4× speedup. Model file sizes remained unchanged at 1.61 MB (MNIST) and 9.44 MB (CIFAR-10) across all sparsity levels, as PyTorch's serialization does not implement sparse storage; computational benefits arise from reduced arithmetic operations, not storage reduction.

### 3.3 Post-Training INT8 Quantization
```{figure} images/fig6.png
:name: fig6
:align: center
Quantization speedup varies by hardware platform. Intel Core Ultra 5 showed larger quantization benefit for CIFAR-10 (1.87× speedup) compared to cloud GPU (1.48× speedup), suggesting NPU optimization for low-precision operations.
```

Dynamic INT8 quantization was applied to all convolutional and linear layers without quantization-aware training (@fig6). Quantization achieved substantial size reductions: MNIST decreased from 1.61 MB to 0.46 MB (3.5× compression), while CIFAR-10 decreased from 9.44 MB to 3.43 MB (2.8× compression).

Quantization maintained or improved test accuracy across all configurations. MNIST quantized models achieved 99.34–99.44% accuracy compared to 99.12–99.44% baseline, showing no degradation and occasional minor improvements. CIFAR-10 quantized models achieved 78.48% accuracy on Colab and Core Ultra 5, a 0.32 percentage point improvement over the 78.16% baseline.

Inference speedup from quantization varied significantly by platform (@fig6). Google Colab achieved 2.08× speedup for MNIST and 1.48× for CIFAR-10. The Intel Core Ultra 5 showed different patterns: 1.18× for MNIST and 1.87× for CIFAR-10. Notably, CIFAR-10 quantization speedup on Core Ultra 5 (1.87×) exceeded the cloud GPU (1.48×), despite the laptop already being 3× faster at baseline. The Lenovo ThinkCentre achieved intermediate speedups of 1.23× (MNIST) and 1.42× (CIFAR-10).

### 3.4 Knowledge Distillation with Reduced-Size Students

Student models with 50% reduced channel dimensions contained approximately 4× fewer parameters than teachers: 105,866 parameters (MNIST) and 620,362 parameters (CIFAR-10). Serialized student models occupied 0.40 MB (MNIST) and 2.37 MB (CIFAR-10), representing 4.0× compression ratios.

Knowledge distillation successfully transferred knowledge with minimal accuracy loss. MNIST student models achieved 99.08–99.15% accuracy, representing 0.04–0.26 percentage point drops from teachers. CIFAR-10 student models achieved 77.17–77.97% accuracy, representing 0.40–1.20 percentage point drops.

Student models achieved the fastest inference of all methods tested. On Lenovo ThinkCentre, MNIST students completed inference in 0.074 ms/image (7.63× faster than cloud GPU baseline), while CIFAR-10 students achieved 0.261 ms/image (10.48× speedup). On Intel Core Ultra 5, students achieved 0.117 ms (MNIST) and 0.430 ms (CIFAR-10), representing 4.83× and 6.36× speedups. Even on cloud GPU, students achieved 4.72× (MNIST) and 4.34× (CIFAR-10) speedups, exceeding the 4× parameter reduction ratio.

### 3.5 Comprehensive Performance Comparison
```{figure} images/fig7.png
:name: fig7
:align: center
Compression methods comparison on Intel Core Ultra 5 across accuracy, size, and latency metrics. Quantization achieved best accuracy for CIFAR-10 (78.48%), while knowledge distillation provided the smallest size (0.40/2.37 MB) and fastest inference (0.117/0.430 ms).
```

```{table}
:name: Table_2
:align: center
| **Dataset** | **Method** | **Accuracy (%)** | **Size (MB)** | **Latency (ms)** | **Speedup** |
|---|---|---|---|---|---|
| MNIST | Baseline | 99.34 | 1.61 | 0.160 | 1.0× |
| MNIST | Pruning (70%) | 99.34 | 1.61 | 0.162 | 1.0× |
| MNIST | Quantization | **99.34** | 0.46 | 0.135 | 1.2× |
| MNIST | Distillation | 99.08 | **0.40** | **0.117** | **1.4×** |
| CIFAR-10 | Baseline | 78.37 | 9.44 | 0.923 | 1.0× |
| CIFAR-10 | Pruning (70%) | 78.03 | 9.44 | 0.836 | 1.1× |
| CIFAR-10 | Quantization | **78.48** | 3.43 | 0.493 | 1.9× |
| CIFAR-10 | Distillation | 77.17 | **2.37** | **0.430** | **2.1×** |
Performance comparison of compression methods on Intel Core Ultra 5 platform. Four configurations tested for each dataset: baseline (no compression), pruning at 70% sparsity, post-training INT8 quantization, and knowledge distillation (4× parameter reduction). Speedup calculated relative to baseline latency on the same platform. Bold values indicate best performance for each metric.
```

@fig7 and @Table_2 provide a detailed Core Ultra 5 comparison across accuracy, size, and latency. For MNIST, all methods maintained >99% accuracy. Quantization and distillation achieved the smallest sizes (0.46 MB and 0.40 MB), while distillation achieved fastest inference (0.117 ms). For CIFAR-10, quantization achieved highest accuracy (78.48%), while distillation achieved smallest size (2.37 MB) and fastest inference (0.430 ms).
```{figure} images/fig8.png
:name: fig8
:align: center
Comprehensive speedup analysis relative to cloud GPU baseline. Maximum speedups: 7.63× (MNIST student, i5-8400) and 10.48× (CIFAR-10 student, i5-8400). Color intensity indicates speedup magnitude.
```


@fig8 presents speedup factors relative to Google Colab baseline across all method-platform combinations. Maximum observed speedups were 7.63× (MNIST student on Lenovo) and 10.48× (CIFAR-10 student on Lenovo). Intel Core Ultra 5 achieved maximum speedups of 4.83× (MNIST student) and 6.36× (CIFAR-10 student). For quantized models, Core Ultra 5 achieved 4.18× (MNIST) and 5.55× (CIFAR-10) speedup relative to cloud baseline.

Three distinct compression strategies emerged: (1) maximum accuracy preservation via 50–70% pruning, maintaining baseline accuracy with minimal benefits; (2) balanced compression via INT8 quantization, providing 3.5× size reduction and maintained accuracy; (3) maximum efficiency via knowledge distillation, achieving 4× size reduction, 4–10× speedup, and acceptable accuracy loss.

---

## Discussion

### 4.1 Added Neural Processing Architecture Provides Superior Inference Performance

Our results demonstrate that Intel Core Ultra 5 NPU-enabled processors achieve 3× faster inference than NVIDIA T4 cloud GPUs for baseline models, challenging conventional assumptions about optimal inference infrastructure. Several architectural factors likely contribute to this advantage. First, the Core Ultra 5 integrates a dedicated Neural Processing Unit explicitly designed for inference workloads, with specialized hardware for efficient matrix operations. Second, on-device inference eliminates network latency and data transfer overhead inherent in cloud deployments. Third, tight integration between CPU, NPU, and memory in the Core Ultra architecture may provide superior memory bandwidth compared to discrete GPU configurations.

The comparable performance of the legacy i5-8400 CPU is particularly noteworthy, as this 2017 processor predates the 2018 T4 GPU yet achieves matching performance. This suggests that CPU architectures, even from several years ago, provide competitive inference performance for small-to-medium models. Modern CPUs have substantially closed the performance gap with GPUs through architectural optimizations including wider vector units, improved prefetching, and better branch prediction. The fact that a consumer-grade desktop CPU from 2017 matches a 2018 datacenter GPU highlights that specialized AI accelerators are not always necessary for efficient inference.

### 4.2 Quantization Shows Platform-Dependent Acceleration

A key finding is that quantization provides disproportionate speedup on NPU hardware compared to cloud GPUs. For CIFAR-10, quantization achieved 1.87× speedup on Core Ultra 5 versus only 1.48× on T4 GPU—a 26% larger acceleration despite the NPU already being 3× faster at baseline. This disparity reveals fundamental architectural differences in low-precision operation handling.

NPUs are explicitly designed for efficient INT8 computation, with dedicated execution units and optimized memory access patterns for quantized operations. GPU architectures, primarily optimized for FP32/FP16, added INT8 support later through tensor cores or specialized units that may not be fully utilized during standard inference workloads. This architectural specialization explains why NPU-enabled devices show amplified quantization benefits.

The slight accuracy improvements with quantization (MNIST: +0.22%, CIFAR-10: +0.32%) are consistent with prior work showing that reduced precision can provide regularization effects. However, this effect is model and dataset dependent and should not be assumed universal.

### 4.3 Task Complexity Determines Pruning Tolerance

The dramatically different pruning tolerance between MNIST and CIFAR-10 reveals task complexity as a critical factor in determining viable compression levels. MNIST maintained full accuracy through 70% pruning, while CIFAR-10 experienced catastrophic degradation at 90% sparsity (19.2 percentage point drop).

This difference likely reflects classification task complexity. MNIST digit recognition requires identifying relatively simple patterns (curves, lines, intersections) captured by a small subset of critical weights. CIFAR-10 object recognition demands distinguishing complex natural images with varying textures, shapes, and contexts, requiring richer feature representations compromised by aggressive pruning.

The 50–70% pruning range appears universally safe for both tasks, suggesting this as a conservative starting point for pruning experiments on novel datasets or architectures. The sharp CIFAR-10 degradation at 90% indicates a critical threshold where the network loses capacity to maintain learned representations.

### 4.4 Legacy Hardware Remains Useful with Model Compression

The exceptional performance of the Intel Core i5-8400 CPU with compressed models (achieving 10.48× speedup over cloud GPUs for CIFAR-10 student models) has important practical implications. Organizations with existing CPU infrastructure may not need specialized AI accelerators for deploying compressed models. This finding is particularly significant for cost-sensitive deployments, educational settings, or developing regions where modern NPU-enabled hardware remains inaccessible.

However, this advantage applies specifically to small, compressed models. Larger models (ResNet, Vision Transformers) or higher-throughput scenarios (batch inference, real-time video processing) would likely still benefit from specialized accelerators. The desktop CPU advantage emerges from efficient cache utilization with small models; student models fit entirely in L2/L3 cache, enabling extremely fast inference through elimination of memory bandwidth bottlenecks.

### 4.5 Practical Deployment Recommendations

Based on our findings, we propose platform-specific deployment guidelines. For NPU-enabled devices (Intel Core Ultra series), INT8 quantization provides optimal balance: 5.5× total speedup, maintained accuracy, and 3× size reduction. Alternatively, knowledge distillation maximizes speed and minimizes size. Pruning should be used conservatively (50–70%) in combination with other methods rather than standalone.

For legacy CPU hardware, knowledge distillation is the primary recommendation, providing up to 10× speedup for small student models. Quantization serves as a secondary option for moderate speedup and size reduction. For cloud deployment scenarios, organizations should reconsider edge deployment, as local NPU inference is 3–6× faster. When cloud deployment is required, quantization still provides cost and latency reduction benefits.

### 4.6 Limitations and Future Directions

This study has several limitations suggesting future research directions. First, we evaluated only simple CNN architectures; larger models (ResNet, EfficientNet, Vision Transformers, LLMs) may exhibit different compression-hardware interactions. Modern architectures with residual connections, attention mechanisms, or neural architecture search may respond differently to compression on NPU hardware.

Second, only image classification on MNIST and CIFAR-10 was tested. Other domains—such as natural language processing, time series prediction, and audio processing—may show different patterns. Third, we did not measure power consumption, which is critical for battery-powered edge devices. NPU advantages may be substantially larger when considering energy efficiency rather than pure speed.

Fourth, compression techniques were tested independently. Future work should explore combinations (e.g., pruning + quantization, or quantization + distillation) that may provide multiplicative benefits. Fifth, laboratory benchmarks may not capture real-world complexities including batch size variation, mixed-precision requirements, or thermal throttling under sustained load.

### 4.7 Broader Implications for AI Deployment

Our findings suggest a potential pattern shift in AI deployment strategy. The historical assumption that cloud-based GPU infrastructure provides optimal inference performance may no longer hold for modern edge devices with specialized AI accelerators. This has implications across multiple dimensions.

Privacy benefits emerge from on-device inference eliminating data transmission to cloud servers, which is particularly important for sensitive applications (healthcare, finance, personal data). Latency advantages from edge deployment enable real-time applications where cloud round-trip time is prohibitive. Cost reductions arise from eliminating cloud API fees and bandwidth costs. Reliability improvements stem from removing dependency on network connectivity.

As NPU technology continues advancing and becomes standard in consumer devices, we may see accelerated migration of AI workloads from cloud to edge. This trend has already begun with smartphone ML capabilities; our results suggest laptop and desktop devices are equally viable deployment targets for appropriately compressed models.

---

## Conclusion

This study systematically evaluated neural network compression techniques across cloud GPU, modern NPU-enabled laptop, and legacy desktop CPU platforms using MNIST and CIFAR-10 benchmarks. Our findings challenge conventional assumptions about optimal inference infrastructure and reveal important hardware-compression interactions.

We demonstrated that Intel Core Ultra 5 NPU-enabled processors achieve 3× faster baseline inference than NVIDIA T4 cloud GPUs, with this advantage amplifying to 5.5× for quantized models. Surprisingly, a 2017 desktop CPU matched cloud GPU performance for baseline models and achieved 10× speedup with knowledge-distilled student models, suggesting that appropriately compressed models enable effective inference on legacy hardware. Among compression techniques, INT8 quantization emerged as the optimal approach for NPU deployment: 3.5× size reduction, maintained accuracy, and 1.87× speedup versus 1.48× on GPU—a 26% larger acceleration revealing architectural optimization for low-precision operations.

Task complexity critically determines pruning tolerance. MNIST maintained accuracy through 70% sparsity whereas CIFAR-10 experienced catastrophic degradation at 90%, suggesting 50–70% as a conservative pruning range. Knowledge distillation provided maximum efficiency (4× compression, 4–10× speedup) with acceptable accuracy loss, while quantization offered optimal accuracy-speed-size balance.

These results suggest a paradigm shift from cloud-centric to edge-centric deployment strategies. Edge deployment with compressed models offers superior inference speed, enhanced privacy through on-device processing, reduced latency without network round-trips, and eliminated cloud API costs. As NPU technology advances and becomes standard in consumer devices, we anticipate accelerated migration of inference workloads to edge platforms, fundamentally reshaping AI deployment architecture for privacy-preserving, low-latency, cost-effective applications.

---

## Acknowledgements

We thank Google Colab for providing cloud GPU resources and acknowledge the use of PyTorch, NumPy, and Matplotlib in implementing and visualizing experiments. Special appreciation to the open-source ML community for datasets and tools that enabled this research.

**Data Availability Statement**

The deidentified data and code that support the findings of this study are openly available at: [github.com/harri-sn-72/ModelCompressionStudy-Morganton](http://github.com/harri-sn-72/ModelCompressionStudy-Morganton).

The repository includes:

Complete experimental results (CSV format)

Jupyter notebooks for all experiments

All code is documented and can be executed to reproduce the findings presented in this study.
