# BRAM-Based-KNN-Accelerator
# FPGA-Based Distance Engine & Nearest-Neighbor Search Accelerator

[![Vivado](https://img.shields.io/badge/Tools-Xilinx_Vivado-orange.svg)](https://www.xilinx.com/products/design-tools/vivado.html)
[![Target-FPGA](https://img.shields.io/badge/Target_Device-Artix--7_xc7a100t-blue.svg)](https://www.xilinx.com/products/silicon-devices/fpga/artix-7.html)
[![Stage](https://img.shields.io/badge/Status-Milestone_1_Complete-green.svg)]()

## 📌 Project Background
This repository presents the first implementation milestone of a larger FPGA-based machine learning accelerator being developed during my internship at the **National Institute of Technology Calicut (NITC)**.

The long-term objective is to develop a crossbar-inspired FPGA architecture capable of accelerating multiple distance metrics for machine learning applications, including Euclidean, Cosine, Mahalanobis, and Kernel-based distance computations. 

As an initial step, this project focuses on the implementation of a **BRAM-based Euclidean Distance Engine** integrated with a pipelined nearest-neighbor search architecture. The design demonstrates how distance computation can be efficiently mapped onto FPGA hardware using on-chip memory, pipelined arithmetic units, and comparator-tree reduction structures.

---

## 🛠️ Current Work
The current hardware implementation includes:
* **BRAM-Based Storage:** Efficient on-chip storage of reference vectors.
* **Euclidean Distance Engine:** Hardware-optimized squared Euclidean distance computation.
* **Distance Buffering Architecture:** Managed data pipelining for continuous processing.
* **Pipelined Minimum-Finder:** A comparator-tree reduction structure to determine the closest match.
* **FSM Controller:** Finite State Machine for robust control logic and synchronization.
* **Functional Verification:** Validated via behavioral and timing simulation using Vivado XSim.
* **FPGA Implementation:** Fully synthesized and implemented targeting the Artix-7 architecture.

> **Core Functionality:** The accelerator computes the squared Euclidean distance between an incoming input query vector and all stored reference vectors, returning the exact index corresponding to the nearest neighbor.

---

## 💡 Research Motivation
Modern machine learning systems frequently rely on distance-based computations for classification, clustering, similarity search, and pattern recognition. Conventional software implementations perform these operations sequentially and often become a severe computational bottleneck for large datasets. 

FPGA-based acceleration bridges this gap by offering:
* **Parallel Computation:** Simultaneous processing of vector dimensions and distances.
* **Reduced Latency & Deterministic Execution:** Crucial for real-time Edge AI.
* **Energy Efficiency:** Higher performance-per-watt compared to traditional CPUs/GPUs.
* **Reconfigurability:** Hardware-level adaptation to evolving ML algorithms.

---

## ✨ Features
* [x] **BRAM-Based Dataset Storage** for high-throughput localized data access.
* [x] **4D Euclidean Distance Computation** core engine.
* [x] **Pipelined Minimum Finder** tree for low-latency reduction.
* [x] **Fully Synthesizable Verilog** RTL design.
* [x] **Artix-7 Compatible** implementation parameters.

---

## 📊 Implementation & Test Results

### Design Parameters
| Parameter | Configuration |
| :--- | :--- |
| **Target Device** | Xilinx Artix-7 (`xc7a100tcsg324-1`) |
| **Dataset Size** | 16 training vectors stored in BRAM |
| **Simulation Testbench** | `tb_knn_bram_top.v` |

### Timing & Verification Results
The design successfully passed implementation and met all timing constraints:
* **Worst Negative Slack (WNS):** `+3.628 ns` (Met)
* **Total Negative Slack (TNS):** `0 ns`
* **Failing Endpoints:** `0`

### Hardware Simulation Sample
Given a sample 4D query vector, the system successfully resolved the closest vector index in hardware:
* **Query Vector:** `(10, 10, 10, 11)`
* **Nearest Index Result:** `13`
* **Calculated Minimum Distance (Squared):** `1`

---

## 🚀 Future Scope
This repository represents the foundational stage of a larger research effort. Future extensions will focus on:

### 1. Multi-Metric Distance Accelerator
Support for additional distance metrics to allow a single accelerator to dynamically switch between multiple similarity measures:
* Cosine Distance
* Mahalanobis Distance
* Kernel (RBF) Distance

### 2. Crossbar-Inspired Memory Architecture
Development of a digital twin of analog crossbar memory using FPGA BRAM resources to emulate conductance-based storage and parallel Vector-Matrix Multiplications (VMM).

### 3. Perovskite Synaptic Device Modeling
Integration of conductance-state information extracted from physical perovskite memristive devices to explore hardware-level neuromorphic computing applications.

### 4. kNN Classification Accelerator
Extension from a simple nearest-neighbor search to a complete hardware-based $k$-Nearest Neighbors ($k\text{NN}$) classification engine with support for $K > 1$.

### 5. Large-Scale Dataset Support
Scaling the architecture beyond BRAM-resident datasets to interface with external memory architectures (e.g., DDR3/DDR4) for larger machine learning workloads.

### 6. Neuromorphic & Reservoir Computing
Application of the developed crossbar-inspired architecture toward future research paradigms:
* Reservoir Computing
* Spiking Neural Networks (SNNs)
* Neuromorphic Hardware Accelerators & Edge AI Systems
