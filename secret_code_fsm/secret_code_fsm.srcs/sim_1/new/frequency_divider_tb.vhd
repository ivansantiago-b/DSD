----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 08:27:16 PM
-- Design Name: 
-- Module Name: frequency_divider_tb - Behavioral
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

entity frequency_divider_tb is
--  Port ( );
end frequency_divider_tb;

architecture Behavioral of frequency_divider_tb is
    signal master_clock : std_logic;
    signal reset : std_logic;
    signal slow_clock : std_logic;
begin
dut:
    entity work.frequency_divider generic map(prescaler => 4) port map(master_clock => master_clock, reset => reset, slow_clock => slow_clock);
stimulus:
    process
    begin
        master_clock <= '0';
        wait for 10 ns;
        master_clock <= '1';
        wait for 10 ns;
    end process;
    
    process
    begin
        reset <= '1';
        wait for 5 ns;
        reset <= '0';
        wait;
    end process;
end Behavioral;
