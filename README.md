# Precision DC Motor Control: PID Tuning, State-Space & Metaheuristic Optimization

This project represents a comprehensive engineering study on the mathematical modeling and automated control of DC motors. It transitions from classical control theory (Ziegler-Nichols) to advanced state-space representations and AI-driven optimization using Genetic Algorithms (GA).

## 🚀 Project Highlights (Based on Research Paper)
- **Mathematical Modeling**: Derived differential equations for the electrical and mechanical subsystems of a DC motor.
- **State-Space Representation**: Developed the state-space model to analyze internal system variables.
- **Advanced PID Features**: Implemented a **Filter Coefficient (N)** in the derivative term to suppress high-frequency noise amplification.
- **Stability Analysis**: Comprehensive validation using **Bode Diagrams** and **Nyquist Plots** to ensure robust stability margins.

## 🛠️ System Architecture & Methodology
The project utilizes a high-fidelity plant model developed in MATLAB/Simulink.

### 1. Plant Modeling
We defined the motor dynamics using the following parameters (as derived in the paper):
- **Electrical**: Resistance ($R$), Inductance ($L$), Back-EMF constant ($K_e$).
- **Mechanical**: Inertia ($J$), Friction ($b$), Torque constant ($K_t$).

### 2. Control Strategies
| Method | Description |
| :--- | :--- |
| **Ziegler-Nichols** | Open-loop step response analysis using the tangent method at the inflection point. |
| **Genetic Algorithm (GA)** | Metaheuristic search for optimal $K_p$, $K_i$, $K_d$ by minimizing a multi-objective cost function. |
| **State-Space Control** | Analysis of the system through state variables for more complex control requirements. |

## 🧬 Genetic Algorithm (GA) Details
The optimization process targets the minimization of a weighted cost function $J$ to achieve a balance between speed and stability:
$$J = \alpha \cdot Overshoot + \beta \cdot SettlingTime + \gamma \cdot SteadyStateError + Penalty$$

- **Settling Time Optimization**: Heavily weighted ($\beta = 0.5$) to ensure rapid system response.
- **Constraint Handling**: A penalty factor is applied if the system exceeds the 2-second stability threshold.

![Optimization Evolution](images/pid_tuning.png)

## 📉 Stability & Frequency Analysis
As detailed in the research paper, the system's stability was verified through frequency response methods. The **Bode Plot** analysis ensures that the phase and gain margins are sufficient to handle load variations without oscillation.

![System Stability Analysis](images/system_architecture.png)

## 📂 File Structure
- `functions/`: Contains the Simulink models (`.slx`) and the GA fitness function.
- `scripts/`: MATLAB scripts for Z-N parameters and performance extraction.
- `docs/`: (Recommended) Place the `komandim det kursi.docx` or a PDF version here for full theoretical reference.

## 🚀 How to Run
1. Open MATLAB and add the project folders to your path.
2. Run `pid_optimizationGA.m` to execute the AI-driven tuning.
3. Observe the output in the **Scope** block of the Simulink model for real-time visualization of the speed regulation.

## 🎓 Academic Credit
This project was developed as part of the "Computer Control" course at the **Polytechnic University of Tirana (FTI)**. 
**Contributors:** Samuel Koçi, Akim Drasa, Franc Kaja, Klajdi Emini.  
**Supervisor:** Prof. Miranda Hariza.
