----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 02:13:32 PM
-- Design Name: 
-- Module Name: bcd_to_7seg - Behavioral
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

entity bcd_to_7seg is
    port(
        bcd : in std_logic_vector (3 downto 0);
        segments : out std_logic_vector (6 downto 0) -- G F E D C B A
    );
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is

begin
    with bcd select
        segments <= "1000000" when "0000",
                    "1111001" when "0001",
                    "0100100" when "0010",
                    "0110000" when "0011",
                    "0011001" when "0100",
                    "0010010" when "0101",
                    "0000010" when "0110",
                    "1111000" when "0111",
                    "0000000" when "1000",
                    "0010000" when "1001",
                    "1111111" when others;
end Behavioral;
