----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 03:32:21 PM
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
    generic(
        n : integer := 8
    );
    port(
        clock, clear, we : in std_logic;
        d : in std_logic_vector(n - 1 downto 0);
        q : out std_logic_vector(n - 1 downto 0)
    );
end reg;

architecture Behavioral of reg is

begin
    process(clock, clear, we)
    begin
        if clear = '1' then
            q <= (others => '0');
        elsif (rising_edge(clock) and we = '1') then
            q <= d;
        end if;
    end process;
end Behavioral;
