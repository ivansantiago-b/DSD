----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 11:02:19 PM
-- Design Name: 
-- Module Name: system - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system is
    port(
        master_clock, reset : in std_logic;
        secret_code : in std_logic_vector(7 downto 0);
        buttons : in std_logic_vector(2 downto 0);
        pass, fail : out std_logic
    );
end system;

architecture Behavioral of system is
    signal slow_clock, pulse_input, clock_pulse: std_logic;
    signal debounced_buttons : std_logic_vector(2 downto 0);
    signal digit : std_logic_vector(1 downto 0);
begin
    U0: entity work.frequency_divider generic map(prescaler => 19) port map(master_clock => master_clock, reset => reset, slow_clock => slow_clock);
    U1: entity work.debounce port map(clock => slow_clock, reset => reset, input => buttons, output => debounced_buttons, button => digit);
    pulse_input <= debounced_buttons(2) or debounced_buttons(1) or debounced_buttons(0);
    U2: entity work.clock_pulse port map(clock => slow_clock, reset => reset, input => pulse_input, pulse => clock_pulse);
    U3: entity work.doorlock port map(clock => clock_pulse, reset => reset, secret_code => secret_code, button => digit, pass => pass, fail => fail);
end Behavioral;
