# ELE432 - Digital System Design | Homework 1
Barış Akgün
21946787
## Traffic Light Controller (FSM)

This repository contains the **SystemVerilog** implementation of a Traffic Light Controller based on a **Finite State Machine (FSM)**. This project was developed as part of the ELE432 course at **Hacettepe University**.

## Project Description
The design manages traffic flow between two streets (Street A and Street B) using a sensor input (`TAORB`) and a timer for transitions.

### Finite State Machine Logic:
- **S0 (Green A):** Street A is Green, Street B is Red. (Stays here as long as TAORB=1)
- **S1 (Yellow A):** Street A is Yellow, Street B is Red. (Waits for 5 clock cycles)
- **S2 (Green B):** Street A is Red, Street B is Green. (Stays here as long as TAORB=0)
- **S3 (Yellow B):** Street A is Red, Street B is Yellow. (Waits for 5 clock cycles)

## File Structure
- `traffic_light_fsm.sv`: Main FSM logic and state transitions.
- `tb_traffic_light.sv`: Testbench for verifying the timing and outputs.

## How to Simulate
The simulation was performed using **QuestaSim**.

1. Create a new project in QuestaSim and add the `.sv` files.
2. Compile all files.
3. Start the simulation without optimization to see internal signals:
   ```tcl
   vsim -voptargs="+acc" work.tb_traffic_light
