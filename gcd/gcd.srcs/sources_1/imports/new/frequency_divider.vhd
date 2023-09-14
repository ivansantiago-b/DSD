----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 08:10:59 PM
-- Design Name: 
-- Module Name: frequency_divider - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity frequency_divider is
    generic(
        prescaler : integer := 16
    );
    
    port(
        master_clock, reset: in std_logic;
        slow_clock : out std_logic
    );
end frequency_divider;

architecture Behavioral of frequency_divider is
    signal counter : std_logic_vector((prescaler - 1) downto 0);
begin
    process(master_clock, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(master_clock) then
            counter <= counter + 1;
        end if;
    end process;
    slow_clock <= counter(prescaler - 1);
end Behavioral;
