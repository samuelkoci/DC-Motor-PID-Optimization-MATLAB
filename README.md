# DC Motor Speed Control Optimization: GA vs. Ziegler-Nichols

This project provides a comprehensive framework for DC Motor speed regulation using **PID Control**, comparing classical engineering methods with **Artificial Intelligence (Genetic Algorithms)**. The goal is to minimize settling time and overshoot through automated metaheuristic optimization.

![Project Banner](images/step_response.png) 

## 📋 Project Overview
The system uses a high-fidelity Simulink plant model to simulate DC motor dynamics. The core of this project is a comparative study between:
1. **Ziegler–Nichols (Z-N) Method**: A classic open-loop tuning approach based on step response analysis.
2. **Genetic Algorithm (GA)**: A global search heuristic that optimizes PID gains ($K_p, K_i, K_d$) by minimizing a custom multi-objective cost function.

## 🛠️ System Architecture & Files
The project is structured into functional modules for easy integration and testing:

| File Name | Category | Description |
| :--- | :--- | :--- |
| `pid_circuit_dcmotorr.slx` | **Plant** | The core Simulink model of the DC motor and PID loop. |
| `pid_optimizationGA.m` | **AI Tuning** | Main script to configure and execute the Genetic Algorithm. |
| `pidFitnessGA.m` | **AI Tuning** | Fitness function evaluating real-time performance in Simulink. |
| `Zieger_Nichols_Parameter.m` | **Classical Tuning** | Estimates gains based on Dead Time ($\theta$) and Time Constant ($\tau$). |
| `TabelaperKontroll.m` | **Analytics** | Extracts performance metrics (Overshoot, Settling Time, Error). |

## 🧬 Genetic Algorithm (GA) Optimization
The GA searches for optimal gains within the defined space:
- **Search Space**: $K_p \in [0, 50]$, $K_i \in [0, 50]$, $K_d \in [0, 10]$.

### Multi-Objective Fitness Function
The system evaluates performance by minimizing a weighted cost function $J$:
$$J = \alpha \cdot Overshoot + \beta \cdot SettlingTime + \gamma \cdot SteadyStateError + Penalty$$

**Optimization Weights:**
- **30%** Overshoot ($\alpha = 0.3$)
- **50%** Settling Time ($\beta = 0.5$)
- **20%** Steady-State Error ($\gamma = 0.2$)
- **Penalty**: A high constant ($\lambda = 100$) is applied if settling time exceeds 2 seconds.

![Optimization Evolution](images/pid_tuning.png)

## 📉 Classical Analysis (Ziegler–Nichols)
The `Zieger_Nichols_Parameter.m` script performs numerical analysis on the step response to determine the critical plant characteristics:
- **$\theta$ (Dead time)**: Estimated via tangent method at the inflection point.
- **$\tau$ (Time constant)**: Calculated as the duration for the tangent to reach steady-state.

![System Architecture](images/system_architecture.png)

## 🚀 Getting Started
1. **Requirements**: MATLAB R2022b or later with *Optimization* and *Control System* Toolboxes.
2. **Setup**: Open the Simulink model `pid_circuit_dcmotorr.slx`.
3. **Execution**:
    - Run `pid_optimizationGA.m` for automated AI-based tuning.
    - Run `Zieger_Nichols_Parameter.m` for the classical baseline.
4. **Validation**: Use `TabelaperKontroll.m` to generate the comparison table of final performance metrics.

## 📊 Results Summary
The GA approach consistently yields a more stable response with significantly lower overshoot compared to the Ziegler-Nichols method, demonstrating the power of metaheuristic search in control system design.
