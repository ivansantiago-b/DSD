----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2023 09:34:16 PM
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
        n : integer := 1
    );
    
    port(
        master_clock, clear : in std_logic;
        output_clock : out std_logic
    );
end frequency_divider;

architecture Behavioral of frequency_divider is
    signal counter : std_logic_vector(n - 1 downto 0);
begin
    process(master_clock, clear)
    begin
        if clear = '1' then
            counter <= (others => '0');
        elsif rising_edge(master_clock) then
            counter <= counter + 1;
        end if;
    end process;
    output_clock <= counter(n - 1);
end Behavioral;
