# MIPI_DSI_DesignVerification
MIPI DSI is a Display interface used in Mobile application for Video data transmission, based on MIPI standard
This project is to verify the design functionality of DSI(Display Serial Interface) Video mode using SV/UVM TB architecture, the TB has following components
1. The TB has two active agents one is AHB Agent to drive input stimulus to configure DSI register block, second is DC Agent (Display controller) to drive input stimulus to the design such as Hsync, Vsync, Pixel Data, Data Valid and Resolution.
2. It has a passive agent, which is PPI Agent(Phy Protocol Interface) to monitor the output data from the design
3. The TB has Scoreboard logic build using UVM Analysis port/Imp to get the data from PPI agent and DC agent and compare for data match.
4. The TB also has Subscriber component to generate functional coverage report for driver input.

Output Waveform:
<img width="1833" height="658" alt="image" src="https://github.com/user-attachments/assets/4c31a35d-ff37-4732-950f-8b453eae619e" />
