----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2023 02:34:19 PM
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
    port(
        a, b : in std_logic_vector(7 downto 0);
        less, equal, greater : out std_logic
    );
end comparator;

architecture Behavioral of comparator is
begin
    less <= '1' when a < b else '0';
    equal <= '1' when a = b else '0';
    greater <= '1' when a > b else '0';
end Behavioral;
