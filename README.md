# Token-Based Queue Management System

### FPGA Mini Project | Verilog HDL | Xilinx Vivado | ZedBoard

## Project Overview

The Token-Based Queue Management System is an FPGA-based digital system designed to automate customer queue management through sequential token generation and service-counter control.

The system uses onboard push buttons to generate tokens, call the next customer and reset the queue. LED indicators display the generated token and serving token values.

## Features

- Sequential token generation (0–15)
- Next customer calling mechanism
- Reset functionality
- LED-based token display
- Button edge detection
- Prevention of invalid customer advancement

## Hardware Requirements

- ZedBoard FPGA Development Board
- Zynq-7000 FPGA
- Onboard 100 MHz clock
- Push buttons BTNU, BTNR and BTNC
- LEDs LD0–LD7

## Software Requirements

- Xilinx Vivado
- Verilog HDL

## System Architecture

1. Push Button Inputs
2. Input Control Logic
3. Token Registers
4. Queue Status Logic
5. LED Outputs

## Working Principle

1. Reset: Clears both token registers.
2. Generate: BTNU generates the next sequential token.
3. Next Customer: BTNR advances the serving token when a customer is waiting.
4. Display: LEDs show the generated and serving token values.

## LED Mapping

- LD7–LD4: Last generated token
- LD3–LD0: Serving token

## Simulation and Results

The design is verified using Vivado behavioral simulation to test token generation, serving operations and reset functionality.

## Applications

- Hospitals
- Banks
- Public service counters
- Customer service centres

## Future Enhancements

- Clock-based button debouncing
- Seven-segment display integration
- Multiple service counters
- Queue-full and queue-empty indicators
- Extended token capacity

## Technologies Used

Verilog HDL | Xilinx Vivado | ZedBoard | FPGA

## Project Presentation

Refer to the PowerPoint presentation included in this repository for the architecture, block diagram, implementation and simulation results.

## Team Members

- Vishruthaa V J
- Yaazhini R
- Sanyo S B
- Rupika Sri S
- Swetha S

## Conclusion

This project demonstrates the implementation of a digital queue management system using Verilog HDL and FPGA technology for efficient token generation and customer service management.
