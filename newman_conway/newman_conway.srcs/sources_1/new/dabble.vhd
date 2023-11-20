----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 04:36:44 PM
-- Design Name: 
-- Module Name: dabble - Behavioral
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

entity dabble is
    port(
        input : in std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0)
    );
end dabble;

architecture Behavioral of dabble is

begin
    with input select
        output <= x"0" when x"0",
                  x"1" when x"1",
                  x"2" when x"2",
                  x"3" when x"3",
                  x"4" when x"4",
                  x"8" when x"5",
                  x"9" when x"6",
                  x"A" when x"7",
                  x"B" when x"8",
                  x"C" when x"9",
                  x"F" when others;
end Behavioral;
