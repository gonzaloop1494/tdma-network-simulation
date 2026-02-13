# TDMA Wireless Network Performance Evaluation (MATLAB)

## Overview
This project evaluates the performance of a multi-user wireless communication system operating over a time-selective Rayleigh fading channel at 1.8 GHz.

The system models 10 mobile users distributed under two spatial scenarios:
- Equidistant distribution
- Random uniform distribution

Different mobility conditions are simulated using Doppler frequencies of 5, 50 and 120 Hz.

The objective is to analyze how radio resource management decisions affect network performance metrics such as delay, reliability and throughput, similar to scheduling problems in cellular networks.

---

## Scheduling Strategies
Two adaptive scheduling algorithms are compared:

### Max-SNR Scheduler
Allocates the transmission slot to the user with the highest instantaneous channel quality.

### Utility-Based Scheduler
Balances channel quality with user waiting time to improve fairness and reduce latency.

---

## Channel Model
- Carrier frequency: 1.8 GHz
- Time-selective Rayleigh fading
- Multiple Doppler scenarios (low, medium and high mobility)

Monte Carlo simulations are used to generate independent channel realizations and evaluate statistical performance.

---

## Performance Metrics
The simulation evaluates:

- Signal-to-Noise Ratio (SNR) distributions (PDF)
- Transmission delay distribution
- Average Bit Error Rate (BER)
- System throughput

For:
- Fixed modulation: 16QAM
- Adaptive modulation: 16QAM / 64QAM under BER constraint

---

## Key Features
- Multi-user TDMA system modelling
- Channel-aware scheduling
- Fairness vs throughput trade-off analysis
- Adaptive modulation gain evaluation
- Statistical performance analysis

---

## Project Structure
src/ → communication system model  
analysis/ → simulation experiments  
docs/ → technical report  

---

## Technologies
MATLAB, wireless communications modelling, Monte Carlo simulation, performance analysis

---

## Educational Purpose
This project was developed to understand practical radio resource management concepts used in modern cellular systems such as scheduling, link adaptation and performance trade-offs between efficiency and fairness.
