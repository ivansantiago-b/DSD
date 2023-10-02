----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/26/2023 08:51:02 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    port(
        clock, reset : in std_logic;
        anodes : std_logic_vector(3 downto 0);
        cathodes : std_logic_vector(7 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    signal sequence : std_logic_vector(1791 downto 0);
begin


end Behavioral;
