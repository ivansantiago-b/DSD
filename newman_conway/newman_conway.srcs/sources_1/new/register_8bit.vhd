----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 01:12:51 PM
-- Design Name: 
-- Module Name: register_8bit - Behavioral
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

entity register_8bit is
    port(
        clock, reset, we : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end register_8bit;

architecture Behavioral of register_8bit is

begin
    process(clock, reset, we)
    begin
        if reset = '1' then
            data_out <= (others => '0');
        elsif rising_edge(clock) then
            if we = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process;
end Behavioral;