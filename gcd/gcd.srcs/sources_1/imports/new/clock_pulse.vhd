----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 09:44:09 PM
-- Design Name: 
-- Module Name: clock_pulse - Behavioral
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

entity clock_pulse is
    port(
        clock, reset, input : in std_logic;
        pulse : out std_logic
    );
end clock_pulse;

architecture Behavioral of clock_pulse is
    signal first_delay, second_delay, third_delay : std_logic;
begin
    process(clock, reset)
    begin
        if reset = '1' then
            first_delay <= '0';
            second_delay <= '0';
            third_delay <= '0';
        elsif rising_edge(clock) then
            first_delay <= input;
            second_delay <= first_delay;
            third_delay <= second_delay;
        end if;
    end process;
    pulse <= first_delay and second_delay and (not third_delay);
end Behavioral;
