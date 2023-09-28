----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2023 02:38:38 PM
-- Design Name: 
-- Module Name: subtractor - Behavioral
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

entity subtractor is
    port(
        a, b : in std_logic_vector(7 downto 0);
        r : out std_logic_vector(7 downto 0)
    );
end subtractor;

architecture Behavioral of subtractor is
begin
    r <= a - b;
end Behavioral;
