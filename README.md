# DC-Motor-PID-Optimization-MATLAB
Automated PID control system for DC Motor speed regulation. This project features a comparative analysis between classical Ziegler–Nichols tuning and Metaheuristic optimization using Genetic Algorithms (GA) to minimize overshoot and settling time.
# DC Motor Speed Control Optimization using Genetic Algorithms

This project presents a comparative study and implementation of control system techniques for regulating the speed of a DC motor. The primary focus is the optimization of PID controller parameters ($K_p, K_i, K_d$) through both classical methods and Artificial Intelligence-based metaheuristic algorithms.



## 📋 Project Overview

The system utilizes a Simulink circuit model (`pid_circuit_dcmotorr.slx`) to simulate the dynamic behavior of a DC motor. To tune the PID controller, two distinct approaches have been implemented:
1. **Ziegler–Nichols Method**: Based on open-loop step response analysis using the tangent method at the inflection point.
2. **Genetic Algorithm (GA)**: A global search heuristic used to find optimal gains by minimizing a weighted multi-objective cost function.

## 🛠️ File Structure

| File Name | Description |
| :--- | :--- |
| `pid_optimizationGA.m` | Main script that configures and executes the Genetic Algorithm. |
| `pidFitnessGA.m` | Fitness function that evaluates PID performance in Simulink and returns a cost value. |
| `Zieger_Nichols_Parameter.m` | Estimates PID coefficients based on dead time ($\theta$) and time constant ($\tau$). |
| `TabelaperKontroll.m` | Extracts performance metrics (Overshoot, Settling Time, Error) after simulation. |
| `pid_circuit_dcmotorr.slx` | The system plant and controller model in Simulink. |

## 🧬 Genetic Algorithm (GA) Optimization

The algorithm searches for optimal values within the following search space:
* **Lower Bounds (lb)**: [0, 0, 0]
* **Upper Bounds (ub)**: [50, 50, 10]

### Fitness Function
System performance is evaluated by minimizing the cost function $J$:
$$J = \alpha \cdot Overshoot + \beta \cdot SettlingTime + \gamma \cdot SteadyStateError + Penalty$$

Where the assigned weights are:
* $\alpha = 0.3$ (Overshoot)
* $\beta = 0.5$ (Settling Time)
* $\gamma = 0.2$ (Steady-State Error)



A **Penalty ($\lambda = 100$)** is applied if the settling time exceeds the 2-second design constraint.

## 📉 Classical Analysis (Ziegler–Nichols)

The script `Zieger_Nichols_Parameter.m` performs numerical analysis on the step response to determine:
* **$\theta$ (Dead time)**: Estimated from the intersection of the tangent line with the time axis.
* **$\tau$ (Time constant)**: The time taken for the tangent to reach the steady-state value.
* **P, PI, PID Coefficients**: Automatically calculated using standard Z-N formulas.



## 🚀 How to Use
1. Ensure MATLAB and Simulink are installed.
2. Open the Simulink model `pid_circuit_dcmotorr.slx`.
3. Run `pid_optimizationGA.m` to start the automated GA tuning process.
4. Run `Zieger_Nichols_Parameter.m` to calculate classical baseline gains for comparison.
5. Use `TabelaperKontroll.m` to verify the final system characteristics.
