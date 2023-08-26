----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 02:11:39 PM
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
        a, b : in std_logic_vector (3 downto 0);
        l, e, g : out std_logic
    );
end comparator;

architecture Behavioral of comparator is

begin
    l <= '1' when a < b else '0';
    e <= '1' when a = b else '0';
    g <= '1' when a > b else '0';
end Behavioral;
