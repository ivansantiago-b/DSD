----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 02:11:09 PM
-- Design Name: 
-- Module Name: bcd_subtractor - Behavioral
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

entity bcd_subtractor is
    port(
        a, b : in std_logic_vector(7 downto 0);
        s : out std_logic_vector (8 downto 0)
    );
end bcd_subtractor;

architecture Behavioral of bcd_subtractor is
    signal sub, sub_aux: std_logic_vector(8 downto 0);
    signal s0, s1 : std_logic_vector(3 downto 0);
begin
    sub <= ('0' & a) - ('0' & b);
    sub_aux <= sub when sub(8) = '0' else ('0' & not(sub(7 downto 0))) + 1;
    s0 <= sub_aux(3 downto 0);
    s1 <= sub_aux(7 downto 4);
    s(8) <= sub(8);
    s(3 downto 0) <= s0 when s0 < 10 else s0 + 10;
    s(7 downto 4) <= s1 when s1 < 10 else s1 + 10;
end Behavioral;
